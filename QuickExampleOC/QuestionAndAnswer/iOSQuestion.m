//
//  iOSQuestion.m
//  QuickExampleOC
//
//  Created by ingo on 2021/5/7.
//

#import <Foundation/Foundation.h>

#pragma mark - iOS
/**
 4. UIView 和 CALayer的关系和区别
 5. UIView 和 CALayer在动画上的区别
 6. frame和bounds在什么情况下是不相等的
 7. bounds x,y 一定是0,0么，为什么
 8. bounds 改成 (50, 50, width, height)会发生什么，view本身，子View？
 1. 说下你在开发过程中遇到过的内存泄漏
 2. NSTimer 怎么处理内存泄漏
 3. Delegate什么情况下会出现内存泄漏，怎么解决
 4. Delegate和Notification的区别
 2. +load 和 initialized方法的区别
 3. +load的调用时机
 4. +load分类中的处理
 5. 分类的实现机制
 6. 分类和类别的区别
 7. 分类中添加属性
 8. 关联对象的原理
 
 3. 开发中遇到的crash
 4. 怎么处理这些crash的，有什么好的解决方案么
 5. 循环引用问题，怎么解决
 6. NSTimer相关，和runLoop的关系
 7. NSTimer、CADisplayLink以及GCD Timer的对比
 3. Timer的使用，怎么避免循环引用
 
 3. frame和bounds的区别
 4. 如果bounds的origin不是00会怎样
 
 2. iOS响应者链，怎么寻找最合适的响应者，如果为nil会怎么办
 
 8. Timmer为啥会有内存泄漏的现象，Runloop会持有Timmer么
 9. 什么是source0和source1，分别做什么事情
 11. UIView 和 CALayer的区别，为什么要这么设计
 12. 隐式动画和显示动画的区别
 
 8. 手指点在高德地图上的一个按钮，会发生什么 ，具体说明
 9. 怎么找到最合适的view
 10. 如过有多个子VC，是先VC还是先View
 11. Runloop是怎么监听到点击事件的
 12. Runloop和线程的关系，Runloop能单独存在嘛
 13. 怎么做到线程保活
 14. A包含B包含C，怎么做才能让C的点击响应区域是 以C对角线为半径的圆弧（要说出具体实现方式）
 
 6. CALayer 和 UIView的关系
 7. 苹果为什么要这么设计
 8. frame、bounds、center
 9. layoutIfNeeded、layoutSubViews、setNeedsDisplay区别
 10. 响应者链（顺便说了下完整的手指触摸屏幕会发生什么引出了后续runloop相关问题）
 11. runloop source0 和 source1都是啥
 12. runloop和线程的关系
 
 5. Runloop和Timer的关系
 6. Runloop能有很多Timer么
 7. 什么是source0 和 source1
 1. 常见的crash
 2. 怎么处理这些crash
 
 2、GCD中的Block是在堆上还是栈上？
 3、NSCoding协议是干什么用的？
 4、KVO的实现原理
 5、NSOperation有哪些特性，比着GCD有哪些优点，它有哪些API？
 6、NSNotificaiton是同步还是异步的，如果发通知时在子线程，接收在哪个线程？
 6. 手指触摸屏幕后系统都做了哪些事情
 7. Runloop是啥，为啥要设计runloop，runloop和线程的关系

 6、NSNotificaiton是同步还是异步的，如果发通知时在子线程，接收在哪个线程？

 3、NSCoding协议是干什么用的？

 
 
 */
