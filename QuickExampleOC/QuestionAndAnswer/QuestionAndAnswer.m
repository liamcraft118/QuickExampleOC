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
 7. 如果是串行队列，会死锁；如果是并行队列，会依次执行；
 8. 自旋锁，信号量，互斥锁，NSLock，NSRecursiveLock，NSConditionLock，@syncronized
 避免资源竞争
 9. GCD group或者利用NSCondition，使用生产者消费者模型
 10. 自旋锁是bool + while，忙等待；信号量是利用lll_futex_wait()让当前线程睡眠，让出睡眠时间。
 11、12、13 不会
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
 8. 后面再说
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
 */

/**
 聊项目：自己项目偏后端，问了很多和后端相关的内容，后续问的问题也基本上要求从客户端和后端双重角度回答
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
 */

/**
 算法题：判断平衡二叉树（easy）
 算法：有一个很大的整形数据，转成二进制求1的个数（因为前面聊比较多，只要求说了下思路）
 算法：求N!
 */
