//
//  OCQuestion.m
//  QuickExampleOC
//
//  Created by ingo on 2021/5/7.
//

#import <Foundation/Foundation.h>

#pragma mark - OC
/**
 1. weak的实现原理
 2. weak弱引用表是可变的么还是不可变的
 3. weak是在什么时候置nil的，如果同时有很多对象对性能影响大怎么办
 5. 多线程相关
 6. iOS中有哪些多线程技术
 7. 如果有两个同步任务嵌套会怎样
 8. 常见的锁，为什么要加锁
 9. C依赖AB任务执行完才能执行，你怎么设计
 10. 读写锁底层怎么实现
 
 1. 进程和线程的区别是啥
 2. 进程的通信机制
 3. 进程A和进程B通过管道通信的话是在同一个管道么
 4. 多线程容易出现的问题，怎么解决
 5. 死锁产生的条件以及对应的解决方案
 6. 自旋锁和互斥锁的区别
 
 1. category的实现原理
 2. weak的实现原理
 
 2. A调用了B方法都做了什么事情
 3. ISA指针
 4. 64位后怎么获取ISA指针
 5. runloop、runtime工作中有接触过嘛
 6. 手指触摸屏幕后系统都做了哪些事情
 
 4. autoreleasePool的底层实现机制
 5. autoreleasePool的底层数据结构，为什么要这么设计
 
 6. iOS中常见的多线程技术
 7. 常见的锁，有什么区别
 8. 如果让你设计读写锁，你怎么设计
 
 1. Objective-C的内存管理
 2. ARC和MRC的区别
 
 5. 多线程一般会有什么问题，请举个例子
 6. 为什么会造成上述问题以及解决方案
 7. 主队列和主线程的关系
 8. 全局并发队列一定在主线程上运行的么
 
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
 
 15. 不通过回到主队列的方式回到主线程（有点没get到点）
 
 1. iOS内存管理（引用计数、修饰词、weak和assign的区别）
 2. runtime（什么是runtime，为啥要有runtime，你用runtime做过什么事情）
 3. 怎么进行方法的交换
 4. +load在什么时候调用的，对启动的影响
 6. GCD信号量，线程同步等
 7. Runloop是啥，为啥要设计runloop，runloop和线程的关系
 
 1. 分类和extension区别
 2. 分类的实现机制
 3. 分类同名方法的调用
 4. 关联对象，策略有哪些，关联对象的key为啥要用static修饰（这个没有get到点）
 5. GCD、NSThread以及NSOperation的区别，怎么取消任务
 6. GCD block内存管理
 
 1. MRC 和 ARC 的区别
 2. ARC有什么缺点
 3. MRC 下 写setter方法
 4. 你理解的id 以及 id 和 void *区别
 5. 函数指针和指针函数的区别
 13. OC 消息发送机制（提到了isa、类对象，引出下面问题）
 14. 写下类的结构
 15. isa在32为和64位的区别
 16. 什么是元类为啥要这么设计
 17. category 和 extension 的区别
 18. +load方法
 
 3. 循环引用和内存泄露
 4. Block造成循环引用的原理
 
 iOS中+load 和 initialized区别
 iOS修饰属性常用的修饰符
 weak和strong的区别
 strong和unsafe_unretained区别
 什么是单例
 对象的比较
 
 8. +load
 
 1、Block是如何实现的？Block对应的数据结构是什么样子的？__block的作用是什么？它对应的数据结构又是什么样子的？
 2、GCD中的Block是在堆上还是栈上？
 3、NSCoding协议是干什么用的？
 4、KVO的实现原理
 5、NSOperation有哪些特性，比着GCD有哪些优点，它有哪些API？
 6、NSNotificaiton是同步还是异步的，如果发通知时在子线程，接收在哪个线程？
 
 进程和线程的区别是啥
 进程的通信机制
 进程A和进程B通过管道通信的话是在同一个管道么
 多线程容易出现的问题，怎么解决
 死锁产生的条件以及对应的解决方案
 自旋锁和互斥锁的却别
 
 */
