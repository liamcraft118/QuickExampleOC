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

// 行为类
/**
 责任链模式：标准模型为链表，抽象append其他抽象，然后用链表头的抽象handleRequest(msg)，将这个msg依次发送给链表上的各个对象。
 将事件的发送与处理解耦，与观察者模式的区别是，观察者模式无差别发送通知，责任链模式有序发送通知，因此可以在中途停止或增加别的逻辑。
 */

/**
 解释器模式：包含终结表达式和非终结表达式，非终结表达式是由各种非终结表达式组合而成。
 有一点组合模式的感觉，部分和整体都都是一种表达形式。不同的是，终结表达式有限，且已知。
 */

/**
 策略模式：拥有一组算法蔟，这些算法蔟在运行时能够被替换；
 例子：鸭子作为客户，有fly()这个方法，fly()中调用flyBehavior这个接口的fly()方法。
 本质上就是client关联一个接口，并有setter方法；当执行client的方法时，调用这个接口的方法。
 实体客户持有一个抽象算法，该算法能够完成某类任务，由于依赖抽象，必然是运行时才知道具体的算法。
 它通过在运行时更换具体算法来完成扩展，那么就是用于这样的场景：一个具体用户，它在不同情况下，会用不同的算法来执行任务。
 */

/**
 观察者模式：被观察者持有多个观察者，在特定时候通知它们；
 被观察者可以理解为客户，客户可抽象可具体，重点在于，
 客户持有一组抽象，且当客户发生变化时，依次调用抽象的算法。
 */

/**
 策略模式和观察者模式的异同：
 从类图上看
 策略模式主体是Strategy接口；
 观察者模式主体是Subject接口和Observer接口，以及它们之间的聚合关系；
 从使用角度来看
 策略模式，一个具体客户持有Strategy抽象即可，当具体客户想要执行算法时，让抽象的实现执行；
 观察者模式，一个具体客户实现Subject抽象，然后就具备持有Observer抽象的能力，当具体客户状态改变时，通知Observer；
 总结
 策略模式
 1. 客户与算法解耦
 2. 算法可以复用
 3. 算法在运行时可以更换
 观察者模式
 1. 主题与观察者解耦，主题仅增加控制notify()的调用时机的逻辑
 2. 观察者在运行时可增减
 如果我们在策略的场景使用观察者模式，在观察者的场景使用策略的模式；
 策略场景：客户执行算法时，通知观察者，但事实上自己并不知道有没有观察者，观察者会做什么，自己想要执行的算法能不能执行。
 反过来说，Strategy抽象是一套能完成完整任务的算法。
 观察者场景：客户状态改变时，通知Strategy抽象执行算法，没有太大的毛病，只不过策略算法数量不能增减
 */

/**
 命令模式：统一方法的调用，对方法调用封装。
 客户本来是要用到多个类的多个方法，各个不同，没有关联。将这些类封装进Command中，在Command的execute()方法中调用这些类的方法，
 达到客户调用这些类的效果，而对于客户而言，需要知道两点：1. Command抽象；2. 每个command实例的具体作用；
 */

/**
 模板方法：抽象类中有一个模板方法和抽象方法，子类实现抽象方法，常用于框架构建。
 */

/**
 迭代器模式：对于聚合类型，封装遍历的过程。
 抽象聚合类能够创建自己的Iterator，Iterator知道抽象集合的本质（数组、字典、集合等），能够执行遍历的逻辑；
 客户依赖聚合类，能够使用聚合类的功能，比如获取元素；客户同时也依赖Iterator，能够通过Iterator遍历聚合类。这里是为了单一职责。
 swift中的array可以forEach，不满足单一职责
 */

// 结构类：用继承的方式，来让类产生新功能；
/**
 适配器模式：将一个类伪装成另一个类。
 对象适配器，适配器继承于目标类，然后关联被适配者；
 类适配器，适配器只能实现目标接口，然后继承被适配者，优点是既实现了目标接口，又保持住了自己被适配者的类型；
 */

/**
 装饰器模式：基础类和装饰类都继承于同一父类，装饰类还持有父类；
 父类为抽象类，基础类实现父类的抽象方法；装饰类除了执行持有的抽象类的相关方法以外，可以执行自己的算法，来完成对类功能的扩展。
 */

/**
 外观模式：多个类需要配合工作，来完成有限个功能时，用一个类将这些类包装起来。
 */

/**
 桥接模式：解耦算法的声明与实现。
 类图上看跟策略模式差不多，唯一区别就是使用者也是抽象，那它们之间的区别就是：
 策略模式：客户调用算法，这些算法是无状态、无数据的
 桥接模式：Abstraction中定义了接口，Implementor中定义了实现，类似于OpenGL和各平台的实现
 */

/**
 组合模式：让部分/整体的调用方式统一。
 类图跟装饰器模式有点像，但目的却不同。
 装饰器模式，通过继承再持有抽象来扩展方法；
 组合模式，每一个component都是独立的，在节点上的不同位置，持有抽象不是为了扩展当前类的方法，而是数据结构就是树形的。
 */

/**
 享元模式：将类似的，重复出现的对象复用；该对象有内部状态和外部状态，内部状态不会改变，外部状态就是暴露给外部改变的。
 UITableViewCell、线程池、Syncronized就是这种结构
 */

/**
 代理模式：继承抽象并持有抽象，控制抽象做事情。
 类图跟装饰器模式很像，但实际侧重点不同：
 装饰器模式：增强对象的方法，增强之后依然是对象本身；
 代理模式：使用对象的方法，来完成任务；
 */

// 创造类:隐藏创建对象细节；
/**
 抽象工厂：创建一组抽象物品（对象）。
 客户让抽象工厂创建多个物品的抽象，客户不知道创建的细节。
 */

/**
 工厂方法：让子类创建对象。父类负责对象的使用。
 */

/**
 建造器模式：将复杂对象的创建过程封装起来，Builder负责创建各个part，Derector来将这个part组合成想要的复杂对象。
 看起来这个设计模式像是创造版本的外观模式，优势就是创造过程变化时，复杂对象类不用改变，只需要改变Builder和Derector。
 */

/**
 原型模式：复制一个自己。
 看似很简单的一个模式，实际上也很简单。麻烦的是，clone()的实现，像组合模式、装饰器模式中的类就很容易实现clone()方法
 */

/**
 单例模式：更合理的可全局访问的类
 */

class StrategyPattern {
}

//protocol ProductA {}
//protocol ProductB {}
//class ProductA1: ProductA {}
//class ProductB1: ProductB {}
//class ProductA2: ProductA {}
//class ProductB2: ProductB {}
//class Client {
//    init(productFactory: ProductFactory) { self.productFactory = productFactory }
//    var productFactory: ProductFactory
//    func operation() {
//        let a = productFactory.createProductA()
//        let b = productFactory.createProductB()
//        doSomething(with: a, productB: b)
//    }
//    func doSomething(with productA: ProductA, productB: ProductB) {}
//}
//protocol ProductFactory {
//    func createProductA() -> ProductA
//    func createProductB() -> ProductB
//}
//class ProductFactory1 {
//    func createProductA() -> ProductA { return ProductA1() }
//    func createProductB() -> ProductB { return ProductB1() }
//}
//class ProductFactory2 {
//    func createProductA() -> ProductA { return ProductA2() }
//    func createProductB() -> ProductB { return ProductB2() }
//}

protocol ProductA {}
protocol ProductB {}
class ProductA1: ProductA {}
class ProductB1: ProductB {}
class ProductA2: ProductA {}
class ProductB2: ProductB {}
class Client {
    init(productFactory: ProductFactory) { self.productFactory = productFactory }
    var productFactory: ProductFactory
    func operation() {
        let a = productFactory.createProductA()
        let b = productFactory.createProductB()
        doSomething(with: a, productB: b)
    }
    func doSomething(with productA: ProductA, productB: ProductB) {}
}
protocol ProductFactory {
    func createProductA() -> ProductA
    func createProductB() -> ProductB
}
class ProductFactory1 {
    func createProductA() -> ProductA { return ProductA1() }
    func createProductB() -> ProductB { return ProductB1() }
}
class ProductFactory2 {
    func createProductA() -> ProductA { return ProductA2() }
    func createProductB() -> ProductB { return ProductB2() }
}
