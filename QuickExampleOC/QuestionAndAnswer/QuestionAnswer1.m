//
//  QuestionAnswer1.m
//  QuickExampleOC
//
//  Created by ingo on 2021/5/7.
//

#import <Foundation/Foundation.h>

#pragma mark - 其他
/**
 14. 动态库和静态库的区别
 */

#pragma mark - 算法
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
 8. LRU、LFU
 */

#pragma mark - 其他语言
/**
 11. JavaScriptCore相关
 12. 什么是JavaScriptCore，JS和Native是怎么进行通信的
 13. 你知道hybrid么，说说你平常怎么使用的（因为没怎么接触过直接说的不会）
 3. RN的原理
 4. RN和flutter的区别
 5. flutter原理
 
 9. RN、flutter、weex：
 10. 你怎么看待这些动态化技术
 11. RN、flutter以及weex的区别
 12. RN怎么和native通信的

 1. Weex和RN以及flutter的区别

 */

#pragma mark - CS
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
 
 Web登录时怎么保持会话状态的
 你知道cookie和session的区别么
 你知道常见的网络攻击么
 什么是中间人攻击原理，怎么预防
 平常用过抓包工具么，说说抓包的原理
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
 HTTP 请求头
 HTTP 状态码
 
 如果让你设计一个HTTPS抓包你回怎么设计
 行间的换页算法有哪些

 */

#pragma mark - 代码题
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

/**
 代码题：（1、输出什么 2、如果是在主线程中会怎么样）
 NSLog(@"1");
 dispatch_sync(^{
 NSLog(@"2");
 });
 NSLog(@"3");
 */
