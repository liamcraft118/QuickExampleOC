//
//  CCUIViewAndCALayerViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "CCUIViewAndCALayerViewController.h"
#import "MyView.h"

/**
 UIView与CALayer
 
 UIView主要是负责创建并管理图层结构，不让CALayer自己管理的原因是为了职责分离。
 
 关系：
 1. UIView创建并持有一个CALayer
 2. UIView是CALayer的delegate
 
 区别
 1. UIView可以响应事件，CALayer不能
 2. CALayer的frame由anchorPoint, position ,bounds, transform共同决定，而UIView只是返回CALayer的frame
 3. UIView负责内容的管理，CALayer负责内容的绘制
 4. UIView禁用了隐式动画，CALayer会产生隐式动画
 
 CALayer等同于纹理，它的contents指向的区域叫做backing stroe，就是保存bitmap的地方，这个bitmap叫寄宿图。
 
 GPU中，经过顶点着色器、图元装配、几何着色器、光栅化、片段着色器、混合与测试之后，就可以将数据交给video controller处理
 在这个过程中，CPU可以提供顶点给GPU使用，或者提供纹理作为片段着色器的输入，来完成渲染
 对应于CALayer，可以使用custom drawing提供顶点数据，或者contents image作为纹理
 
 Contents Image
 layer.contents需要传入CGImage，否则没有作用（或者mac os中的NSImage)
 
 Custom Drawing
 自定义绘制是指使用Core Graphic绘制寄宿图，一般重写UIView的drawRect:，但实际上是CALayer完成了绘制任务
 
 ref: http://chuquan.me/2018/09/25/ios-graphics-render-principle/
 
 渲染流程
 
 1. Handle Events: 首先处理事件，这些事件会导致UI的改变
 2. Commit Transaction: CPU处理显示内容的前置计算，比如视图的创建、布局计算、解码图片、文字绘制等。最后将打包好的数据发送给Render Server
 3. Decode: Render Server接收到打包的图层数据，然后进行解码，完成之后，在下一个run loop，进行Draw Call.
 4. Draw Call: 解码完成后，Render Server会调用下层渲染框架（OpenGL/Metal），将数据交给GPU渲染
 5. Render: GPU对数据进行渲染，经过顶点着色器、图元装配、几何着色器、光栅化、片段着色器、混合与测试
 6. Display: Render结束后的下一个run loop，将数据显示
 
 Commit Transaction分为4个部分：
 1. Layout
 调用layoutSubViews、计算视图布局（即Layout Constraint）
 2. Display
 这个阶段主要对应CALayer中的display方法执行的时机，一般情况下，是交给Core Graphic进行视图的绘制。
 这里的绘制指的是根据Layout提供的布局数据来创建图元(primitives)数据，并没有在CPU中绘制bitmap。一般情况下bitmap是在GPU中进行绘制的。
 但如果实现了drawRect:方法，那么便会在这里面使用Core Graphic在CPU中绘制bitmap，并且会专门申请一块内存来存储这个bitmap。
 3. Prepare
 图片的解码和转换
 4. Commit
 图层树递归打包发送，如果图层树层级很深，commit的开销就很大。
 
 OffScreen Renderering 离屏渲染
 
 首先区别CPU渲染和CPU离屏渲染，
 CPU渲染：
 1. drawRect:中使用CoreGraphic框架进行绘制
 2. 文字渲染
 3. 图片解码
 这些都是在CPU中进行，都会用CPU生成bitmap，都会暂时存放在另一块内存中，但却不是我们要说的离屏渲染。

 GPU离屏渲染
 Render Server遵循”画家算法“，让GPU从远到近依次进行绘制，依次输出到frame buffer中，这就导致在绘制这一层的时候，之前若干层的数据已经丢失了。
 如果要绘制一个带圆角并且剪切圆角以外内容的容器，只能先将这个容器对应的layer以及子layers绘制到一块独立内存中，然后再将这些结果绘制到frame buffer中，
 这个过程中，上下文需要在frame buffer和另一外内存之间切换，这个过程开销很大。
 
 为了更好的理解为什么需要单独开辟一块内存来保存绘制过程中的中间结果，我查阅了一些资料，
 一个说法是，”当图层属性的混合体被指定为在未预合成之前不能直接在屏幕中绘制“，这句话解释的不是很清楚，但却说明了不得不重新开辟内存的原因，即带有圆角、裁切这类属性的图层不能直接绘制，
 而需要分别各自先完成合成（也就是绘制成bitmap）之后，再依次将这些bitmap绘制到frame buffer中。
 个人的理解是：一般情况下，绘制layer时，遍历layer树依次生成bitmap，并依次输入到frame buffer中，每一次输入之后进行混合与测试，所以不存在裁剪的机会。
 那么为了绘制圆角并裁切，当遇到这样的layer时，先将layer与子layers绘制在其他内存中，然后分别对它们进行裁切，最后在将结果依次输入到frame buffer中。
 
 值得一提的是，与一般桌面架构不同，iOS中，内存与显存共享物理内存。
 
 ref: https://zhuanlan.zhihu.com/p/72653360
 http://www.cocoachina.com/articles/898639
 https://www.jianshu.com/p/6b9a5f16644b
 http://chuquan.me/2018/09/25/ios-graphics-render-principle/
 
 呈现树与渲染树
 呈现树一般而言是图层树的复制，主要用于Core Animation中的动画绘制。
 当执行Core Animation动画时，我们首先会将图层打包，提交给Render Server，这个提交的数据就是呈现树，然后Render Server会修改呈现树的数据，然后操作GPU进行绘制，
 在这个时候，图层树的数据是没有变化的，这也是为什么动画完成之后，视图中的layer会突然回到动画开始的地方。
 
 渲染树其实就是将图层树的顶点坐标、顶点颜色等这些信息抽离出来，形成的树结构。
 
 ref: https://www.jianshu.com/p/abf9bde5bd6a
 */

@interface CCUIViewAndCALayerViewController ()

@end

@implementation CCUIViewAndCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *mView = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    mView.backgroundColor = UIColor.systemBlueColor;
    [self.view addSubview:mView];
}

@end
