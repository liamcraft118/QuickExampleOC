//
//  QuestionAndAnswer.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/13.
//

#import <Foundation/Foundation.h>

/**
 代码阅读题：(问输出)
 TestObject *object1 = [[TestObject alloc] init];
 __block TestObject *object2 = [[TestObject alloc] init];
 object1.name = @"Mike";
 object2.name = @"Sean";
 __block int vi = 1;

 void (^handler)(NSString *) = ^(NSString *name) {
     object1.name = name;
     object2.name = name;
     vi = 2;
 }
 handler(@"Lucy");

 NSLog(object1.name);
 NSLog(object2.name);
 NSLog(@"%i", vi);
 引申：

 如果__block int vi = 1; 这句改成int vi = 1会怎样，为什么
 代码中的block是什么block，为什么
 */
/*
 1. 输出分析：object2和v1的指针都会被赋值到堆中，object1和object2的指针一个在栈，一个在堆，但他们指向的对象都是之前的object1和object2，
 不过这些对输出都没什么影响，输出结果为Lucy、Lucy、2
 2. 去掉__block，编译阶段会报错，因为MallocBlock中持有的vi是在堆中，而int vi是在栈中，是两个不同的内容。
 3. MallocBlock，因为它捕获了栈中的数据，那么就会在堆中申请一块内存，用来存放block以及它捕获的数据
 */

/**
 1. weak的实现原理
 2. weak弱引用表是可变的么还是不可变的
 3. weak是在什么时候置nil的，如果同时有很多对象对性能影响大怎么办
 4. UIView 和 CALayer的关系和区别
 5. UIView 和 CALayer在动画上的区别
 6. frame和bounds在什么情况下是不相等的
 7. bounds x,y 一定是0,0么，为什么
 8. bounds 改成 (50, 50, width, height)会发生什么，view本身，子View？
 */
/*
 1. 被weak标记的属性在进行set操作的时候，不进行retain操作，然后用一个全局的table以对象的地址为key，以一个保存指向对象的指针的数组为value，将这些数据保存起来。
 2. 可变的，因为要添加键值对
 3. 在对象执行dealloc时，会从table中获取弱引用指针的数组，然后让这些指针都指向nil。如果对性能产生了影响，可以使用unsafe_unretained或者assign指向对象。
 4. UIView继承于UIResponder，主要负责事件响应和视图层级的管理。
 CALayer负责的是内容的绘制。UIView都会对应一个CALayer，并且是CALayer的delegate，在绘制的最后阶段会询问UIView是否需要再画点什么。
 UIView的frame、center只是从CALayer获取的，CALayer才是真正拥有这些属性
 5. UIView默认隐式动画是关闭的，而对于CALayer属性的修改会产生隐式动画。
 6. bounds的origin修改时；layer的transform发生变化时，比如旋转；
 7. 不一定，bounds描述的是自身坐标体系下的位置关系，它的origin值可以修改，根据origin的值，layer表示的内容会发生相应的移动。但UIView代表的视图并不会变化。
 8. view本身没有变化，依然代表的是相对于父视图(origin, size)这个坐标下的矩形视图，而layer代表的内容会向左、上分别移动50个点。
 */

/**
 1. 说下你在开发过程中遇到过的内存泄漏
 2. NSTimer 怎么处理内存泄漏
 3. Delegate什么情况下会出现内存泄漏，怎么解决
 4. Delegate和Notification的区别
 5. 多线程相关
 6. iOS中有哪些多线程技术
 7. 如果有两个同步任务嵌套会怎样
 8. 常见的锁，为什么要加锁
 9. C依赖AB任务执行完才能执行，你怎么设计
 10. 读写锁底层怎么实现
 11. JavaScriptCore相关
 12. 什么是JavaScriptCore，JS和Native是怎么进行通信的
 13. 你知道hybrid么，说说你平常怎么使用的（因为没怎么接触过直接说的不会）
 14. 动态库和静态库的区别
 */
/*
 1. block、delegate引起的循环应用; NSTimer持有target引起的内存泄漏。
 2. runloop会持有NSTimer，NSTimer会持有target。需要手动invalidate和timer = nil。
 3. 强相互引用时会出现内存泄漏，将delegate用weak修饰
 4. delegate是一对一，notification是一对多
 从一般用途来讲，delegate是命令式的，即委托他人做什么事情；而notification是响应式的，即收到了这个通知，我要如何回应。
 本质上来讲，都是对象之间通信的方式，delegate是通过相互引用，调用对象的方法来实现；notification是将自己注册进全局数组中，发送端遍历数组，调用方法来实现。
 5,6. pthread, NSThread, GCD, NSOperation
 NSOperation中有异步任务时，重写isExecuting和isFinished，在start和main中手动控制isExecuting和isFinished的值。
 记得手动触发KVO
 https://stackoverflow.com/a/33555576/4789773
 7. 如果是串行队列，会死锁；如果是并行队列，会依次执行；
 8. 自旋锁，信号量，互斥锁，NSLock，NSRecursiveLock，NSConditionLock，@syncronized
 避免资源竞争
 9. GCD group, NSOperation的addDependency
 或者利用NSCondition，使用生产者消费者模型
 10. 自旋锁是bool + while，忙等待；信号量是利用lll_futex_wait()让当前线程睡眠，让出睡眠时间。
 11、12、13 不清楚
 14. 静态库：.a、.framework，链接时完整地拷贝到可执行文件中，如果有多份引用，就会有多份拷贝
 动态库：.dylib、.framework，链接时不复制，程序运行时，由系统动态加载到内存，系统只加载一次，多个程序使用
 */

/**
 1. 了解业内性能优化是怎么做的么
 2. 你项目中是怎么做性能优化的
 3. RN的原理
 4. RN和flutter的区别
 5. flutter原理
 */
/*
 1、2 性能优化 https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/
 高度缓存，异步渲染，避免离屏渲染
 3. javaScriptCore用来解释js代码，ReactJS用来指挥原生组件进行绘制和更新，Bridges用来翻译ReactJS的绘制指令
 4. react native调用原生进行绘制，flutter自己进行绘制
 5.
 */

/**
 1. 动态库和静态库的区别
 2. +load 和 initialized方法的区别
 3. +load的调用时机
 4. +load分类中的处理
 5. 分类的实现机制
 6. 分类和类别的区别
 7. 分类中添加属性
 8. 关联对象的原理
 */
/*
 1. 前面回答过了
 2、3、4 当class或者category被添加到runtime时，会执行load方法，执行顺序，父类->当前类->category。作用，method swizzling。
 当向class发送第一条消息时，会执行initialize方法，执行顺序，父类->当前类。
 5. category是利用runtime实现的，它本质上是个结构体，里面存储属性、成员方法、类方法、协议。
 在运行时，category里面存储的属性、成员方法会被添加到Class中，而类方法会被添加到MetaClass中
 6. category和extension主要的区别就是，category是在运行时执行的，而extension是编译时执行的。
 7. 分类中能添加属性，但却不能添加实例变量，因为category的结构体中没有保存实例变量的数组，但却可以通过关联对象添加。
 8. 关联对象，是添加变量到Class中，因为Class的struct有保存关联对象的数组，也提供了相应的方法。
 */

/**
 1. 进程和线程的区别是啥
 2. 进程的通信机制
 3. 进程A和进程B通过管道通信的话是在同一个管道么
 4. 多线程容易出现的问题，怎么解决
 5. 死锁产生的条件以及对应的解决方案
 6. 自旋锁和互斥锁的区别
 7. 什么是虚拟内存，虚拟内存和物理内存的关系和区别
 8. LRU、LFU
 */
/*
 1. 一个进程包含一个或多个线程，进程独享内存资源，而多条线程是共享这些资源。但每个线程也有自己的程序计数器、本地方法栈等
 2. URL Scheme, key chain, UIPasteboard, UIDocumentInterfaceController, mach port(local socket), AirDrop, UIActivityViewController, App Groups
 3. 不清楚
 4. 资源竞争，加锁
 5. 不清楚
 6. 自旋锁忙等待，互斥锁用到了lll_futex_wait()让线程休眠，让出时间片
 7. 不清楚
 8. 不清楚
 */

/**
 1. category的实现原理
 2. weak的实现原理
 3. 开发中遇到的crash
 4. 怎么处理这些crash的，有什么好的解决方案么
 5. 循环引用问题，怎么解决
 6. NSTimer相关，和runLoop的关系
 7. NSTimer、CADisplayLink以及GCD Timer的对比
 */
/*
 1. runtime实现的
 2. 表以对象为key，保存了一个数组，数组中保存的是指向这个对象的指针
 3. 野指针、数组越界、访问没有实现的方法（delegate类型为id)
 KVO crash，重复移除未注册的观察者、添加了观察者但没有实现-observer...:
 4. 野指针使用weak，访问没有实现的方法，可以利用消息转发机制解决
 5. 使用weak解决循环引用，weakProxy解决强引用问题（NSTimer）
 6. NSTimer也就是CFRuntimeTimerRef，它会唤醒runloop来执行相应任务
 7. NStimer和CADisplayLink都是利用runloop来实现的，底层是mk_timer，而GCD的timer是用的内核时钟。一般来说GCD Timer要准一些，因为依赖于runloop的timer会受到runloop执行耗时任务的影响。
 */

/**
 1. 需求中的难点，你是怎么解决的
 2. A调用了B方法都做了什么事情
 3. ISA指针
 4. 64位后怎么获取ISA指针
 5. runloop、runtime工作中有接触过嘛
 6. 手指触摸屏幕后系统都做了哪些事情
 7. 怎么监听页面的卡顿
 8. 怎么监听函数执行时间
 */
/*
 1. 主要做业务，遇到的问题不算太难，有印象的，有个离线下载的功能，大概就是从服务器拿到一个文件列表，然后下载这些文件。这里就涉及到多线程，
 一个线程每隔一段时间去拉这个接口，另一个线程处理数据，比如跟本地数据对比，然后再交给下载的线程去完成下载操作。说起来也不算复杂。中间遇到一些多线程问题，
 比如用到了NSOperationQueue，用法也很简单，把任务添加进去就行了。碰到的细节问题，比如调cancel()之后，到底怎么cancel的这个问题，就直接看苹果的文档，
 文档里面说的挺详细，就是执行了cancel()方法，标志位cancel变成了true，至于你里面还在跑的业务，你自己想办法停。已经发出去的请求，你自己想办法忽略。
 2. 执行objc_msgSend(object, _cmd)，给A发消息，叫A执行名为B的方法，A会依次从cache_list，class_method_list，super_class_method_list依次去找有没有这样的方法，如果有，就通过哈希表找到这个方法对应的实现，然后执行；
 如果没有，则进入消息转发，分别为(Bool)resolveInstanceMethod:(SEL)sel, (id)forwardingTargetForSelector:(SEL)sel, methodSignatureForSelector:(SEL)sel, forwardInvocation:(NSInvocation *)anInvocation
 首先是给自己一个机会，把这个方法加到Class中，然后转发给其他实现了这个方法的对象去执行，最后数据都给你，你自己想怎么处理怎么处理。
 3. objc_object包含isa指针，objc_class继承于objc_class，并且包含指向父类/元类的指针，还包括方法列表、属性列表、协议列表
 对象的isa指针指向类，类的isa指针指向元类
 类的superClass指向父类，最终指向rootClass，也就是NSObject
 元类的superClass指向元类的父类，最终指向rootMetaClass
 rootMetaClass的isa指向自己，superClass指向rootClass
 4. 不清楚
 5. runloop是为了确保有一条线程一直存活着来执行任务，没事的时候，能够睡眠减少资源消耗，有事的时候能够被唤醒执行任务。
 runloop有一些mode，常见的有NSDefaultRunloopMode和UITrackingRunloopMode，他们之间的区别是，它们各自持有的source不一样，他们可以有不同的source、timer、observer。
 比如滑动的时候主线程的runloop是运行在UITrackingRunloopMode下，这个目的是为了滑动流畅，避免一些耗时的操作。
 source0就是一个普通的任务，source1是一个能够唤醒runloop的任务，而timer是定时触发的任务。
 runtime是运行时
 6. 首先屏幕接收到触摸这个事件，IOKit会将这个事件进行封装，交给SpringBoard，SpringBoard自己响应或者交给当前正在运行的app进程的主线程，是一个source1任务，这个任务被执行的时候会生成一个source0任务，将这个触摸事件分发下去。
 接下来是事件的分发，自底向上，由UIApplication->UIWindow->user interface，分发过程利用hitTest:和positionInside:确定自己是否应该响应事件，如果需要响应，则返回自己。
 最后就是响应事件，自顶向下，对于UIResponder而言，在touchBegan时，执行[super touchBegan]则将事件交给自己的下一层view/viewController来响应
 对于UIGestureRecognizer，具有更高的响应优先级，事件会先发给UIGestureRecognizer，如果手势响应这个事件，会cancel掉UIResponder中的响应
 对于UIControl是UIResponder相关touchBegan的封装
 7. 通过runloop的observer监听beforeWaiting，利用信号量设置超时等待时间，如果超时，则说明主线程卡顿了。
 主线程中执行dispatch_semaphore_signial让等待的线程执行，表明主线程没有卡顿。
 8. 只知道思路，hook objc_msgSend这个方法，先记录时间，然后执行objc_msgSend，然后再记录时间，计算这个时间的差值
 */

/**
 1. Objective-C的内存管理
 2. ARC和MRC的区别
 3. Timer的使用，怎么避免循环引用
 4. autoreleasePool的底层实现机制
 5. autoreleasePool的底层数据结构，为什么要这么设计
 6. iOS中常见的多线程技术
 7. 常见的锁，有什么区别
 8. 如果让你设计读写锁，你怎么设计
 9. RN、flutter、weex：
 10. 你怎么看待这些动态化技术
 11. RN、flutter以及weex的区别
 12. RN怎么和native通信的
 */
/*
 1. 程序运行需要占用内存，那么就需要释放内存；在短时间内占用大量内存，也需要处理。
 栈内存不需要我们管理，我们需要管理的是堆内存。
 2. ARC自动引用计数，MRC手动引用计数，主要区别在于ARC中的引用计数的处理是自动的，而MRC是手动的，相关方法包括retain, release, autorelease
 3. 添加进runloop，让target指向weakProxy，或者手动让[timer invalidate]
 4. autoreleasePool是在runloop enter的时候创建，beforeWaiting时重置，exit时销毁
 5. autoreleasePool数据结构是栈，把需要自动释放的对象依次压入栈，在需要释放的时候依次出栈进行release
 6. pthread, NSThread, GCD, NSOperation
 7. 自旋锁，信号量，互斥锁，NSCondition，NSLock, NSRecursiveLock, @synconized
 8. 忙等待利用bool和while，闲等待利用lll_futex_wait()
 9. 不清楚
 10. 他们都是在深入了解iOS底层实现的基础上完成的，RN是基于javaScriptCore，而Flutter是基于surface，openGL
 11. 不清楚
 12. 不清楚
 */

/**
 1. QA发现了一个按钮无法响应点击事件，可能是什么原因导致的（说了五种情况好像没有答到面试官要的点）
 2. iOS响应者链，怎么寻找最合适的响应者，如果为nil会怎么办
 3. frame和bounds的区别
 4. 如果bounds的origin不是00会怎样
 5. 多线程一般会有什么问题，请举个例子
 6. 为什么会造成上述问题以及解决方案
 7. 主队列和主线程的关系
 8. 全局并发队列一定在主线程上运行的么
 9. 项目相关，用了什么技术，有哪些难点，怎么处理的
 */
/*
 1. 被透明的UIView遮挡
 layer的bounds的origin不为0，导致layer显示在响应区域外
 没有添加响应事件、添加了相应事件但逻辑有问题导致没有执行
 要响应这个事件的对象被释放了
 按钮重写了hitText:或者touchBegan
 按钮中有一个UIResponder响应并拦截了这个事件
 2. -
 3. -
 4. -
 5. 资源竞争，比如一个线程在遍历数组，另一个线程往数组里面添加/删除数据
 执行顺序先后问题
 6. 加锁或者用一个串行队列
 7. "主队列存储要执行的任务，主线程来执行这些任务，他们是一对一的"
 update: 之前的回答有误，主队列的任务一般在主线程上运行，全局队列的任务一般是在子线程中运行，但都有例外。
 执行dispatch_main()之后，主线程会被阻塞，并且将主队列的任务交到子线程中执行。
 在主线程中dispatch_sync(globalQueue)执行任务，任务是在主线程中执行。
 8. 有可能运行在主线程上，比如用dispatch_sync
 9. -
 */

/**
 1. 项目中遇到的问题，怎么解决的
 2. 聊了聊OC中的内存管理
 3. 一个对象什么时候会引用计数+1，什么时候引用计数-1
 4. 对象A copy后生成字符串对象B AB引用计数是怎样的
 5. 如果A是可变的呢
 6. 关键字，readonly有了解吗
 7. 修饰对象的默认关键字是啥
 8. category相关，category是怎么实现的
 9. category的结构
 10. category中的方法会覆盖原来类的方法吗
 11. category中怎么区分开类方法和实例方法的
 12. category的方法是怎么插入到类(元类)对象方法列表中的
 13. 同时最多执行5个任务怎么设计
 14. AFN中 success 和 fail block是在子线程还是主线程
 15. 不通过回到主队列的方式回到主线程（有点没get到点）
 16. SDWebImage的下载原理
 17. 如果有两个相同的url，SDWebImage是怎么处理的
 */
/*
 1. 项目有一个需求，实现类似苹果自带计算器按键效果，就是按下之后，移动手指，当离开按钮时，按钮恢复normal状态，移动到其他按钮时，这个按钮要高亮。
 2. retain, release, autorelease
 3. retain时+1，release时-1
 4. A、B是同一个，引用计数为2
 这里有错误，引用计数应该为3，copy内部会实例化对象，分配内存，然后autorelease
 5. A、B是不同的对象，引用计数都为1
 这里也有错误，A的引用计数为1，B的引用计数为2
 6. 只读，存在Class的class_ro_t中，只有get方法，所以只读。
 7. atomic, readwrite, strong
 8. category是用runtime实现的
 9. category保存了实例方法、类方法、属性、协议
 10. 不会，只是加到前面
 11. 两个不同的数组
 12. 在运行时初始化时，把这些加入进去的，调用runtime相关的的接口
 13. 高层API的话，NSOperationQueue可以实现，maxConcurrentOperationCount = 5，
 14. 不清楚，猜测是在子线程
 15. 利用runloop，perform:onThread，source0，source1，timer，observer都可以
 16. 不清楚
 17. 不清楚，不过肯定有缓存，url就是key
 */

/**
 1. iOS内存管理（引用计数、修饰词、weak和assign的区别）
 2. runtime（什么是runtime，为啥要有runtime，你用runtime做过什么事情）
 3. 怎么进行方法的交换
 4. +load在什么时候调用的，对启动的影响
 5. 代码题：ABCDE五个任务，D依赖AB的执行，E依赖BC的执行，怎么设计
 6. GCD信号量，线程同步等
 7. Runloop是啥，为啥要设计runloop，runloop和线程的关系
 8. Timmer为啥会有内存泄漏的现象，Runloop会持有Timmer么
 9. 什么是source0和source1，分别做什么事情
 10. 怎么监测app卡顿
 11. UIView 和 CALayer的区别，为什么要这么设计
 12. 隐式动画和显示动画的区别
 */
/*
 1. -
 2. -
 3. class_replaceMethod()
 4. Class添加进runtime时
 5. 高层API，NSOperation，或者生产者-消费者模型，D等AB信号，E等BC信号
 6. 加锁
 7. -
 8. -
 9. -
 10. 监听runloop的afterWaiting和beforeWaiting状态，用信号量判断是否超时。afterWaiting时开始等待，beforeWaiting时通知完成。如果超时，则卡顿，没有超时，则继续下一个循环。
 11. 职责分离。UIView响应事件、管理视图、无动画，CALayer绘制、委托、有隐式动画
 12. 不清楚
 */

/**
 1. 分类和extension区别
 2. 分类的实现机制
 3. 分类同名方法的调用
 4. 关联对象，策略有哪些，关联对象的key为啥要用static修饰（这个没有get到点）
 5. GCD、NSThread以及NSOperation的区别，怎么取消任务
 6. GCD block内存管理
 7. 自己实现一个函数，其中有个形参是block，这个block是什么时候进行copy的，一定会进行copy操作嘛
 8. 手指点在高德地图上的一个按钮，会发生什么 ，具体说明
 9. 怎么找到最合适的view
 10. 如过有多个子VC，是先VC还是先View
 11. Runloop是怎么监听到点击事件的
 12. Runloop和线程的关系，Runloop能单独存在嘛
 13. 怎么做到线程保活
 14. A包含B包含C，怎么做才能让C的点击响应区域是 以C对角线为半径的圆弧（要说出具体实现方式）
 */
/*
 1. 运行时注入和静态编译
 2. runtime
 3. 遍历Class中的方法列表，找到第二个
 4. retain, copy, assign, nonatomic
 5. NSOperation底层使用的是GCD，GCD和NSThread应该都是对pthread的封装，NSOperation中有cancel。GCD和NSThread只能手动了，添加一个bool值，在回调中处理。
 6. GCD的block会在执行完之后自行释放，不会造成循环引用
 7. ARC情况下，应该是创建的时候进行copy的，用weak进行修饰应该不会copy
 8. 响应链
 9. hitTest:和positionInside:
 10. 响应时，先view再vc，子vc也是先view再子vc
 11. IOKit给runloop发消息
 12. runloop就是线程里面跑的一串循环执行的代码
 13. 添加port
 14. 我们先假设A的hitTest:方法会执行，然后计算出C中的(0, 0)点在A中的位置，以这个点为圆心，C对角线的长度为半径，利用贝塞尔曲线画一个圆，
 判断点击的点是否在这个圆之内，如果是返回C
 */

/**
 1. 代码题：
 下方代码中三个数组中的p.name是啥，为什么
 Person *p = [[Person alloc] init];
 p.name = @"zhangsan";

 NSArray *a = @[p];
 NSArray *b = [a copy];
 NSArray *c = [a mutableCopy];

 Person *p2 = [c firstObject];
 p2.name = @"lisi";
 
 2. 下方代码会有什么问题，为什么
 NSNotificationCenter *__weak center = [NSNotificationCenter defaultCenter];
 id __block token = [center addObserver:kDdiRegisterNotification
                                 object:nil
                                  queue:[NSOperationQueue mainQueue]
                             usingBlock:^(NSNotification *note) {
                                     [self getDataWithComplete:completeBlock];
                                     [center removeObserver:token];
                                  }];

 */
/*
 1. 分析：
 b是指针复制，内容不变，a、b都指向同一个数组，a、b中保存到指向p的指针不同，p指向的地址相同
 c是内容复制，c指向另一个数组，c中p的指针变了，但p指向的内容相同
 p2指向的是p的对象，修改名字后，p.name发生了变化
 
 2. 据我了解，第一句代码就会产生一个warning，告诉你这个对象立马就会被释放，但实际运行时却没有被释放，我以为是debug的问题，结果在release跑也没有释放。
 那么既然没有释放，它就能成功添加观察的内容，token也能正常生成，但在usingBlock的时候，center由于是弱引用，变为了nil。
 */

/**
 1. MRC 和 ARC 的区别
 2. ARC有什么缺点
 3. MRC 下 写setter方法
 4. 你理解的id 以及 id 和 void *区别
 5. 函数指针和指针函数的区别
 6. CALayer 和 UIView的关系
 7. 苹果为什么要这么设计
 8. frame、bounds、center
 9. layoutIfNeeded、layoutSubViews、setNeedsDisplay区别
 10. 响应者链（顺便说了下完整的手指触摸屏幕会发生什么引出了后续runloop相关问题）
 11. runloop source0 和 source1都是啥
 12. runloop和线程的关系
 13. OC 消息发送机制（提到了isa、类对象，引出下面问题）
 14. 写下类的结构
 15. isa在32为和64位的区别
 16. 什么是元类为啥要这么设计
 17. category 和 extension 的区别
 18. +load方法
 */
/*
 1. -
 2. 缺点可能是会在性能上有一定影响，尤其是大家对内存管理不够了解之后再写代码。
 3. -
 4. id是指向NSObject对象的指针，而void *是指向任意类型的指针
 5. 指针函数是指一个函数返回值是一个指针；函数指针是指指向函数的指针。
 6. -
 7. 职责分离
 8. 相对父类坐标，相对自身的坐标，中心店
 9. layoutIfNeeded是立马执行layout操作，这个操作是在UI刷新中的commit transaction的过程中，在这个过程中会执行layoutSubviews。
 setNeedsDisplay是将这个layer的display状态标记为dirty，等下一次runloop的时候，更新这个layer的UI。
 10. -
 11. -
 12. -
 13. (BOOL)resolveMethodInstance:(SEL)sel, forwardTargetForSelector, methodSignatureForSelector, forwardInvocation
 14. isa super_class cache bits(class_rw_t)
 15. 不清楚
 16. 形成闭环
 17. 运行时和编译器
 18. Class加载到runtime时
 */

/**
 代码题：（1、输出什么 2、如果是在主线程中会怎么样）
 NSLog(@"1");
 dispatch_sync(^{
     NSLog(@"2");
 });
 NSLog(@"3");
 */
/*
 输出1、2、3，或者1
 */

/**
 1. Weex和RN以及flutter的区别
 2. 要是收到了内存警告怎么办
 3. 循环引用和内存泄露
 4. Block造成循环引用的原理
 5. Runloop和Timer的关系
 6. Runloop能有很多Timer么
 7. 什么是source0 和 source1
 8. Timer一定是准时的吗，为什么
 9. FPS怎么监控，上传时机
 */
/*
 1. 不清楚
 2. 如果是正在进行图片加载、下载相关操作的话，可以将缓存清除掉
 主要还是通过一些手段预防占用内存过多，比如使用NSCache，将图片压缩，将循环体内的临时变量加到autoreleasePool中
 3. -
 4. vc会持有block，而block再持有vc就会造成循环引用
 5. runloop持有timer，然后执行相关任务
 6. 可以
 7. 我理解为一个事件
 8. 不准时，受runloop中实际执行的任务的影响
 9. 利用CADisplayLink，在屏幕完成一次更新之后执行，然后在里面计算1秒钟执行了多少次这个方法。
 */

/**
 iOS中+load 和 initialized区别
 iOS修饰属性常用的修饰符
 weak和strong的区别
 strong和unsafe_unretained区别
 什么是单例
 对象的比较
 */
/*
 1. -
 2. -
 3. -
 4. -
 5. -
 6. 重写isEqualTo
 */

/**
 1. 常见的crash
 2. 怎么处理这些crash
 3. 怎么设计一个crash日志回捞系统
 4. Objc为啥要设计消息发送机制，直接调函数不好吗
 5. 怎么获取函数的堆栈
 6. 怎么监控APP卡顿
 7. APP启动做了哪些事情怎么优化
 8. +load
 9. 怎么进行业务解耦
 10. APP性能优化相关
 11. 设计一个下载任务
 12. 可以并行也可以串行
 13. 有最大的并发数量
 14. 可以断点续传
 15. 如何解耦
 16. 缓存怎么设计（说了LRU、LFU）
 */
/*
 1. 野指针、数组越界、访问没有实现的方法
 2. 规避
 3. 不清楚
 4. 动态语言
 5. https://zhuanlan.zhihu.com/p/138755187
 6. 子线程中记录runloop开始执行的状态，用信号量等待超时时间，在runloop结束执行的时候，调用信号量。
 7. 加载动态库、ImageLoader加载image，runtime执行Class的+load方法
 8. -
 9. -
 10. -
 11. -
 16. -
 */

/**
 1、Block是如何实现的？Block对应的数据结构是什么样子的？__block的作用是什么？它对应的数据结构又是什么样子的？
 2、GCD中的Block是在堆上还是栈上？
 3、NSCoding协议是干什么用的？
 4、KVO的实现原理
 5、NSOperation有哪些特性，比着GCD有哪些优点，它有哪些API？
 6、NSNotificaiton是同步还是异步的，如果发通知时在子线程，接收在哪个线程？
 */
/*
 1. 是一个struct，有isa指针，invoke函数指针，variables存储捕获的变量
 2. 堆上
 3. 编码、解码时依赖该协议
 4. 利用runtime生成中间对象，让isa指针指向这个中间对象，重写setter方法，插入willChangeValueForKey:和didChangeValueForKey:
 5. 面向对象，提供cancel()方法，能够设置依赖
 6. 同步，子线程
 */

/**
 1. 什么是异步渲染？
 2. layoutsubviews是在什么时机调用的？
 3. 一张图片的展示经历了哪些步骤？
 4. 什么是离屏渲染，什么情况会导致离屏渲染？
 5. CoreAnimation这个框架的作用什么，它跟UIKit的关系是什么？
 */
/*
 1. 子线程绘制，主线程显示。
 UIView的显示是通过CALayer来实现的，CALayer的显示则是通过contents来完成的。我们不能在子线程中将内容绘制到layer的contents中，但我们可以在子线程中，
 通过CGBitmapContextCreateImage，将绘制内容，再切回主线程，将内容复制给layer.contents
 2. init不会调用
 frame值改变时，UIScrollView滚动时，setNeedsLayout时，addSubView时，屏幕旋转时
 3. 分配内存缓冲区，将图片数据从磁盘读取到内存中
 在渲染之前，将图片数据解码，这一步发生在主线程中
 然后将解码后的数据交给GPU渲染
 4.
 */

/**
 你了解的网络协议
 HTTP和TCP、UDP的联系
 HTTP和HTTPS的区别
 HTTPS的原理
 在HTTPS建立连接的时候都用了哪些加密算法，为什么要这么设计
 常见的加密算法
 对称加密算法和非对称加密算法的区别
 说说点击一个按钮后打开一个web页面从发送网络请求到页面展示都做了啥
 为什么能通过一个URL就能请求到对应的资源（域名解析等）
 如果客户端上有个按钮，点击会触发一次网络请求，在短时间内快速点击，怎么处理（从客户端以及服务端角度思考）
 知道什么是HTTPDNS么
 GET请求和POST的区别，POST请求参数能放在URL中么为啥
 你了解的HTTP请求响应状态码
 说说为什么要设计304这个状态码
 */
/*
 1. 常见网络协议https://juejin.cn/post/6844903951335178248
 */

/**
 Web登录时怎么保持会话状态的
 你知道cookie和session的区别么
 你知道常见的网络攻击么
 什么是中间人攻击原理，怎么预防
 平常用过抓包工具么，说说抓包的原理
 如果让你设计一个HTTPS抓包你回怎么设计
 进程和线程的区别是啥
 进程的通信机制
 进程A和进程B通过管道通信的话是在同一个管道么
 多线程容易出现的问题，怎么解决
 死锁产生的条件以及对应的解决方案
 自旋锁和互斥锁的却别
 什么是虚拟内存，虚拟内存和物理内存的关系和区别
 行间的换页算法有哪些
 LRU、LFU
 继续问项目，为啥要做这些东西，碰到了什么难点
 你觉得你的优势和缺点是啥
 自己的未来规划
 还有什么想问的么
 http header 和 body
 GET和POST请求
 GET请求参数一定是放在URL中的么
 HTTPS （TLS是啥，怎么建立连接等）
 你平常用过Charles么，说说Charles的抓包原理
 Charles能抓HTTPS么，怎么实现
 HTTPS怎么建立连接的
 中间人攻击，怎么避免
 JS是怎么和Native通信的
 模块表是怎么生成的
 JS函数注入怎么做的
 RN 和 Weex 的区别
 HTTP 请求头
 HTTP 状态码
 */

/**
 算法题：判断平衡二叉树（easy）
 算法：有一个很大的整形数据，转成二进制求1的个数（因为前面聊比较多，只要求说了下思路）
 算法：求N!
 字符串转整形
 反转链表（递归和非递归）
 将两个有序链表合并成一个有序链表
 算法: 山脉数组找目标值(要求logN的时间复杂度)
 算法：有个view有很多子view，没个子view中也有很多子view，找出所有的按钮，并切圆角（图的BFS）
 算法：两题LC medium（都要求写完跑case）
 给定一个数字n 求出全部集合（n = 3 输出 [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]）
 Lc 200 求岛屿个数
 算法题 判断镜像二叉树
 算法：两数之和（要求空间复杂度O(1)）
 算法：开根号（要求跑case）
 算法：链表反转
 */

/**
 1. LRU、LFU
 2. APP性能优化，https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/
 */

// 新一轮面试题
// https://juejin.cn/post/6860888953638256654
