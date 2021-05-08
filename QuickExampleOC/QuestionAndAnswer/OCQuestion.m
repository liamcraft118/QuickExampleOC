//
//  OCQuestion.m
//  QuickExampleOC
//
//  Created by ingo on 2021/5/7.
//

#import <Foundation/Foundation.h>


// 解释原理，附带工作中的应用

#pragma mark - OC

// 内存管理理论
/**
 1. Objective-C的内存管理
 OC使用的是引用计数来管理内存，当持有对象时，该对象的引用计数+1，释放该对象时，引用计数-1，如果该对象的引用计数为0，则执行dealloc方法。
 内存管理相关方法：retain, release, retainCount, autorelease
 创建规则：
 创建并持有，alloc, new, copy, mutableCopy
 创建不持有，大部分类方法初始化，比如[NSArray array]，内部实现是创建并持有了对象之后，为了对象能够返回，执行了autorelease
 释放规则：持有则释放，不持有则不释放
 相应的关键字有retain, strong, copy, weak, assign, unsafe_unretained, atomic, nonatomic, readonly, readwrite, getter, setter
 
 2. MRC和ARC的区别
 ARC不需要手动写retain, release, autorelease，而是在编译期和运行时两个阶段自动帮助开发者管理内存。
 编译期，编译的时候，自动在相应的位置加入retain, release, autorelease
 运行时，weak修饰的对象引用计数为0时，将指向这个对象的指针置为nil
 autorelease之后，执行了retain的情况，先执行objc_autoreleaseReturnValue，而后执行objc_retainAutoreleaseReturnValue，主要是进行标志位的检查，不实际进行autorelease和retain操作，速度更快
 
 3. 说说copy, mutableCopy
 首先，copy和mutableCopy的实际结果，是根据各个类的具体实现来的，分别是实现NSCopying和NSMutableCopying，对应copyWithZone:和mutableCopyWithZone:这两个方法
 其次，聊聊常见的NSString和NSArray。常提到的由两个概念，深复制和浅复制，
 对于NSString, NSArray而言，copy是浅复制，mutableCopy是深复制，
 对于NSMutableString, NSMutableArray而言，copy, mutableCopy都是深复制，
 因此NSString, NSArray执行copy时，返回的是自己本身，然后retain了
 然后，对于NSArray, NSMutableArray的copy, mutableCopy的过程中，如果数组中保存的是引用类型，在复制的过程中，引用类型的对象并没有复制，只不过新增了指向这些对象的指针而已。
 
 4. weak实现原理，对性能的影响
 有一个全局的Table，里面以对象地址为key，以数组为value的数据，数组中保存的是指向该对象的weak关键字修饰的指针地址。
 如果对性能有影响，可以使用assign，然后自己维护已释放的指针指向的内容。
 
 5. autoreleasePool是什么？底层实现机制、数据结构是什么？
 autoreleasePool自动释放池，能够帮助开发自动释放申请的内存。
 AutoreleasePoolPage双向链表结构，数据结构类似栈，执行时，首先将哨兵对象入栈，然后将各个方法体内的对象加入到栈中，
 在方法体结束的时候，依次出栈的同时，对每一个对象执行release，直到最后让哨兵对象出栈，结束整个过程。
 
 6. Block是如何实现的？Block对应的数据结构是什么样子的？__block的作用是什么？它对应的数据结构又是什么样子的？
 block为OC对象，有三种，分别为NSConcrateStackBlock, NSConcrateGlobalBlock, NSConcrateMallocBlock，
 没有捕获任何变量时，为GlobalBlock，存储在常量区；MRC中，捕获了变量时为StackBlock，StackBlock进行了copy之后会成为MallocBlock。
 ARC中，捕获变量时均为MallocBlock，编译器会帮助进行copy。因此MRC中用copy修饰block，而ARC中，strong, copy皆可。
 ARC中，有四种情况会自动对block进行copy:
 1. block作为函数返回值时
 2. block赋值给__strong指针时
 3. block作为Cocoa API中方法名含有usingBlock:时
 4. block作为GCD API的方法参数时
 
 block结构体中包含isa, invoke, variables，捕获的变量在编译时，存放在block结构体中，
 对于捕获的变量，基础数据类型为值传递，引用类型/static修饰的变量为指针传递，全局变量不进行捕获，直接使用
 block对象在进行变量捕获的时候，对于__strong修饰的对象，会retain，而对于__weak修饰的对象，不会retain。block从堆上移除之前，会释放自己持有的对象
 
 __block
 __block能够让值类型能够在block中进行修改，编译器会将__block修饰的变量包装成一个对象，这个对象持有需要修改的值，block持有这个对象。
 
 ref: https://juejin.cn/post/6844903893176958983#heading-46
 
 */

// 内存管理实践
/**
 1. 对象A，copy后生成字符串对象B，AB引用计数是怎样的？如果A是可变的呢？
 如果A为NSString，copy之后，生成的B与A为同一个对象，引用计数为2。A为可变的情况下，copy之后，生成的B为新的对象，它们各自的引用计数均为1。
 如果A为自定义对象，并且按常规方式实现了的话，copy会生成新的对象，A和B各自的引用计数为1
 
 2. 关键字readonly有了解吗
 只读，声明的对象只会合成get方法，执行set操作的时候会报编译错误。
 
 3. 修饰对象的默认关键字是啥
 readwrite, atomic, strong
 
 4. ARC有什么缺点
 非objc对象不会自动释放，
 降低了开发者入门的难度，也让入门开发者不太注重内存管理
 
 5. MRC下写setter方法
 - (void)setName:(NSString *name) {
    if (_name != name) {
        [_name release];
        [name retain];
        _name = name;
    }
 }
 
 6. Block造成循环引用的原理
 一个对象持有block，block中又捕获了该对象，形成循环引用
 
 7. 循环引用和内存泄露
 常见的容易引起循环引用的情况，delegate, block, NSTimer
 */


/**
 // runtime
 1. 聊聊iOS中的rumtime
 OC是动态语言，它在运行时可以动态的创建类、对象，进行消息传递、转发。所以需要一套机制来保证这样的特性能够正常运行，runtime就是这样的一套机制。
 在runtime中，
 
 8. category相关，category是怎么实现的
 9. category的结构
 10. category中的方法会覆盖原来类的方法吗
 11. category中怎么区分开类方法和实例方法的
 12. category的方法是怎么插入到类(元类)对象方法列表中的
 1. category的实现原理
 3. ISA指针
 4. 64位后怎么获取ISA指针
 2. A调用了B方法都做了什么事情
 5. runloop、runtime工作中有接触过嘛
 2. runtime（什么是runtime，为啥要有runtime，你用runtime做过什么事情）
 3. 怎么进行方法的交换
 4. +load在什么时候调用的，对启动的影响
 1. 分类和extension区别
 2. 分类的实现机制
 3. 分类同名方法的调用
 4. 关联对象，策略有哪些，关联对象的key为啥要用static修饰（这个没有get到点）
 4. 你理解的id 以及 id 和 void *区别
 5. 函数指针和指针函数的区别
 13. OC 消息发送机制（提到了isa、类对象，引出下面问题）
 14. 写下类的结构
 15. isa在32为和64位的区别
 16. 什么是元类为啥要这么设计
 17. category 和 extension 的区别
 18. +load方法
 iOS中+load 和 initialized区别
 8. KVO的实现原理

 // 多线程
 5. 多线程相关
 6. iOS中有哪些多线程技术
 7. 如果有两个同步任务嵌套会怎样
 8. 常见的锁，为什么要加锁
 10. 读写锁底层怎么实现
 1. 进程和线程的区别是啥
 2. 进程的通信机制
 3. 进程A和进程B通过管道通信的话是在同一个管道么
 4. 多线程容易出现的问题，怎么解决
 5. 死锁产生的条件以及对应的解决方案
 6. 自旋锁和互斥锁的区别
 6. iOS中常见的多线程技术
 7. 常见的锁，有什么区别
 8. 如果让你设计读写锁，你怎么设计
 5. 多线程一般会有什么问题，请举个例子
 6. 为什么会造成上述问题以及解决方案
 7. 主队列和主线程的关系
 8. 全局并发队列一定在主线程上运行的么
 15. 不通过回到主队列的方式回到主线程（有点没get到点）
 6. GCD信号量，线程同步等
 5. GCD、NSThread以及NSOperation的区别，怎么取消任务
 6. GCD block内存管理
 2、GCD中的Block是在堆上还是栈上？
 进程和线程的区别是啥
 进程的通信机制
 进程A和进程B通过管道通信的话是在同一个管道么
 多线程容易出现的问题，怎么解决
 死锁产生的条件以及对应的解决方案
 自旋锁和互斥锁的却别
 5、NSOperation有哪些特性，比着GCD有哪些优点，它有哪些API？

// 其他
 什么是单例
 对象的比较
 */
