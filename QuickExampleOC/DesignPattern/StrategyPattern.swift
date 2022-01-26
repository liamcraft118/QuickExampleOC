//
//  StrategyPattern.swift
//  QuickExampleOC
//
//  Created by ZhouYingguo on 2022/1/26.
//

import Foundation

/**
 创造类：隐藏创建对象细节；
 结构类：用继承的方式，来让类产生新功能；
 行为类：主要处理对象间的交互；
 */

/**
 策略模式：拥有一组算法蔟，这些算法蔟在运行时能够被替换；
 例子：鸭子作为客户，有fly()这个方法，fly()中调用flyBehavior这个接口的fly()方法。
 本质上就是client持有一个接口，并有setter方法；当执行client的方法时，调用这个接口的方法。
 */
class StrategyPattern {
    
}
