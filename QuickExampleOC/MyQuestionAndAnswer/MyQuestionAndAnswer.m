//
//  MyQuestionAndAnswer.m
//  QuickExampleOC
//
//  Created by ingo on 2021/4/16.
//

#import <Foundation/Foundation.h>

/**
 1. 主队列和主线程的关系
 2. 其他队列中的任务，会在主线程中执行吗？
 3. [NSThread isMainThread]返回true，那么UI就可以在这个线程更新吗？
 4. 5个请求，一个回调，两种方法
 5. 信号量，signal 1和互斥锁有区别吗
 6. NSOperation中添加异步任务需要注意什么
 7. [UIView animateWithDuration]中的block会不会造成循环引用，为什么？
 8. objc_msgSend执行过程
 9. 三个UILabel并排，挤压中间的label，用什么属性
 10. block都有哪些？
 */
/*
 1. 主队列的任务不一定都在主线程中执行，主线程中也不只执行主队列的任务。 https://www.jianshu.com/p/a110d5038a2d
 2. 会，dispatch_sync(global_queue, block)就是
 3. 不清楚
 4. dispatch_group可以解决、还差一个
 5.
 */

/**
 1. NSMutableArray用copy修饰会怎么样？
 */
/*
 1. 崩溃
 */

/**
 1. 一张图片显示在屏幕上，占多少字节？
 2. UITableView中大量图片/内容需要渲染，滑动过程中导致卡顿，如何优化？
 3. 二叉树有哪些遍历的方法？
 4. 关系型数据库table之间有哪些关联方式？
 5. struct和class之间有什么区别？
 6. json字符串解析？
 7. NSOperation处理异步任务，有哪些需要注意的？
 8. GCD和NSOperation的区别
 9. swift中map、flattenMap、compactMap之间的区别？
 10. optional的map有什么用？
 11. swift中codable有哪些协议？
 12. UIView和CALayer之间的区别
 13. 一个链表，如何判断它有环？
 14. NSMutableArray用copy修饰会怎么样？
 15. UIWebView、WKWebView中JS的调用时同步还是异步的？
 16. include和import有什么区别？include如何避免多次引用的问题？
 */

/**
 method_list中存的是什么内容
 聊聊MVP和MVVM的区别
 聊一聊组件化开发
 NSString执行copy，返回的是不是同一个对象？
 delegate和block的区别？
 */

/**
 OC支持重载吗？为什么？如果让你设计，如何能够让OC支持重载？
 如何只让类的一部分对象中的两个方法进行方法交换？
 利用运行时创建中间类继承这个类，然后让这部分对象的isa指针指向这个类，交换这个类中的方法。
 如何设计一个模块以达到封装性和扩展性？
 你的项目中遇到过最难的bug是如何解决的？
 KVO如何写的？原理是什么？
 performSelector:afterDelay在子线程中能执行吗？
 Block中不用写weakSelf的有哪些例子？
 GCD、enmuratingUsingBlock、[UIView animationWith]
 */
