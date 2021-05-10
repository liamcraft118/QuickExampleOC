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


// runtime基础
/**
 1. 聊聊iOS中的rumtime
 OC是动态语言，它在运行时可以动态的创建类、对象，进行消息传递、转发。所以需要一套机制来保证这样的特性能够正常运行，runtime就是这样的一套机制。
 
 runtime中的数据结构, objc_object和objc_class，其中objc_object中包含一个isa_t isa指针，在64为系统中,isa_t是一个union，我们暂时把理解为一个指向Class的普通指针。
 objc_class继承于objc_object，除此之外还包含Class superClass; cache_t cache; class_data_bits_t bits;
 Class为指向objc_class的指针，id为指向objc_object的指针。
 
 superClass
 一个对象的实例（即objc_object)的isa为objc_class
 一个类(即objc_class)的isa为元类，类的superClass为它的父类
 NSObject为类最终的根类，元类的最终的根类为root元类
 root元类的isa为NSObject，形成一个闭环
 
 cache
 cache_t可增量扩展的哈希表结构, key为无符号的长整型，value为IMP
 cache_t本质是一个结构体，里面包函数bucket_t的数组，mask代表缓存bucket的总数，occupied代表实际占用的数量
 
 bits
 class_data_bits_t是对class_rw_t的封装，class_rw_t包括class_ro_t, protocols, properties, methods，
 class_ro_t包括protocols, properties, methods, name, ivars,
 class_ro_t是编译时确定的协议、属性、方法、类名和成员变量,
 class_rw_t中的数据是运行时添加进来的，先添加分类中的协议、属性、方法，再添加clas_ro_t,

 method_t
 method_t是结构体，其中包含SEL name; const char *types; IMP imp;
 methods是数组，其中包含了method_t，其中types是不可变字符类型指针，代表函数的组成结构，一般为"v@:"，"v"代表返回值为void，"@"代表传入的第一个参数为对象（self)，":"代表传入SEL
 
 2. 消息转发
 根据实例对象、类对象、元类对象的关系图，我们可以知道：
 类对象存储实例方法列表等信息
 元类对象存储类方法列表等信息
 类对象和元类对象都是objc_class，都继承于objc_object，都有isa指针，
 所以实例对象可以通过isa找到类对象，进而访问类对象存储的数据，类对象也可以通过isa找到元类对象，进而访问元类对象存储的数据。
 
 有了以上基础，下面来看看实例对象调用实例方法的过程：
 缓存查找：根据SEL计算出哈希值，从哈希表中查找IMP返回给调用方。
 当前类查找：遍历methods，找到与SEL相匹配的IMP，然后添加到cache中
 父类逐级查找：先查看父类的cache，再查看methods，找到IMP之后，添加到cache中
 如果还没有找到，就会走消息转发流程resolvedInstanceMethod, forwardingTargetForSelector, methodSignagureForSelector, forwardInvocation
 
 method-swizzing
 @dynamic

 ref: https://www.jianshu.com/p/c339d331e23e
 
 3. category的结构？如何区分类方法和实例方法？方法是如何加入到对象方法列表中的？实现原理？同名方法的调用？
 category的数据结构：name, cls, instanceMethods, classMethods, protocols, instanceProperties;
 编译时，会构建category结构体，保存在DATA数据段，用于运行时category的加载。
 运行时，会先将category的数据加载到类中，再添加类本身的数据。

 */

// runtime实践
 /**
  1. [self class]和[super class]返回的是同一个类吗？
  一般而言，class这个方法，NSObject的子类都没有重写，所以最终调用的是它们的根类（即NSObject）中的class方法。
  因此结果一定是相同的，返回当前类的类名。
  
  2. isKindOfClass和isMemberOfClass的区别？
  isKindOfClass判断是否是某个类或者是这个类的子类
  isMemberOfClass判断是否是某个类

  3. category和extension的区别？
  extension的内容在编译期时决定的，一般用来隐藏类的私有信息，必须要有源码才能为一个类添加extension，可以添加实例变量。
  category中的内容是在运行时被添加到类中的，可以为已存在的类动态添加方法，不能添加实例变量。

  4. ISA指针是什么？64位后怎么获取ISA指针？
  TBD
  
  5. A调用了B方法都做了什么事情
  方法调用以及消息转发
  
  6. 你用runtime做过什么事情？
  UITableView的空页面，利用setDataSource获取dataSource对应的类，然后hook方法numberOfRow，根据返回值数量，添加或者移除空页面。
  
  7. 怎么进行方法的交换
  method swizzing
  
  8. +load在什么时候调用的，对启动的影响？和initialize的区别？
  在类被加载到runtime的时候被调用，如果在+load中做了太多事情，就会明显地影响到启动的速度。
  initialize方法在对象的第一个方法被调用时执行，执行顺序是父类->当前类->category
  
  9. 关联对象，策略有哪些，关联对象的key为啥要用static修饰（这个没有get到点）
  assign, copy, copy_nonatomic, retain, retain_nonatomic
  static代表这个key在编译时就能确定，取地址就能获取到不可变的空类型指针，满足参数的定义
  
  10. id和void *区别
  id是指向objc_object的指针，一般而言也就是指向NSObject的指针，可以向id对象进行任意方法调用，运行时会执行或者报错；
  void *表示指向任意类型的指针，该指针指向一块内存地址，但不清楚这块内存地址对应的是什么内容；
  
  11. 函数指针和指针函数的区别
  函数指针是指指向一个函数地址的指针，指针函数是指返回值为一个指针的函数。
  
  12. OC消息发送机制？类的结构？isa32位和64位的区别？为什么元类要这么设计？
  消息发送与转发。类的结构，继承于objc_object，包括Class superclass; cache_t cache; class_data_bits_t bits;
  32位的isa指针指向Class的内存地址，
  64位的isa指针是一个union，用33位保存了Class的内存地址，其他位作为标志位，与第三位为0的ISA_MASK进行与操作，会获得Class的真实地址
  ref: https://juejin.cn/post/6844903993961873415
  ref: https://halfrost.com/objc_runtime_isa_class/
  
  13. 如果我们调用一个类方法，没有对应的实现，但是有同名的实例方法实现，会不会发生崩溃？会不会产生实际的调用？
  如果是NSObject中有同名的实例方法，不会产生崩溃，会产生实际的调用。
  类方法会遍历元类的方法列表，以及元类父类的方法列表，直到根元类，直到根元类的父类，即NSObject类，这时候就会遍历NSObject的方法列表来进行响应。
  
  14. KVO的实现原理
  运行时，动态生成一个新的类Notify_Foo继承于Foo，重写需要观察的属性的set方法。在set方法中调用willChangeValueForKey:和didChangeValueForKey:
  在didChangeValueForKey:中会调用observerValueForKeyPath:方法
  */

/**
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
