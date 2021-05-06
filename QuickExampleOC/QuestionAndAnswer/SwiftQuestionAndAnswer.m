//
//  SwiftQuestionAndAnswer.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/25.
//

#import <Foundation/Foundation.h>

/**
 1. class 、struct、enmu 的区别?
 都可以定义属性和方法，下标语法访问之，初始化器，支持协议、扩展
 类：继承、类型转换、析构方法类型转换、引用计数
 class: 引用类型，可继承
 struct: 值类型，不可继承，多线程时保证数据不被修改
 
 enum
 优点：
 RawRepresentable自动提供初始值
 CaseIterable返回allCases
 Associated Value能够让enum代表具有不同值的枚举类型
 能够扩展protocol
 可以创建初始化方法
 每个Enum都有自己的命名空间
 缺点：
 由于case是预先确定的，所以不能扩展case，对于有这方面需求的方案，不太适合
 
 struct
 相对于enum，没有枚举值、可以声明存储属性
 值类型
 扩展性更强
 不能继承
 
 class
 相对于struct，引用类型，可继承
 优点：
 耗内存的数据存放在class中，
 需要依次修改，全部更新时，使用class
 缺点：
 基类在编译时没有手段让子类必须override某个方法
 子类需要初始化基类的属性
 基类的设计需要前瞻性，这一点很难
 可能会有循环引用、内存泄漏等内存问题
 
 
 2. 非继承下的代码复用方式?
 .swift文件中直接写方法，相当于全局函数
 extension给类扩展方法
 
 3. Set独有的方法有哪些？
 并集、交集、差集、对称差集
 
 4. 交换数组中的两个元素？
 可以用元组的形式直接进行交换
 可以使用泛型，解决类型问题
 
 5. 实现一个 min 函数，返回两个元素较小的元素
 a < b ? a : b，再加上泛型
 
 6. map、filter、reduce 的作用
 map映射
 filter过滤
 reduce加总
 
 7. map和flatMap的区别
 flatMap可以将元素映射成可选型
 
 8. 什么是copy on right?
 swift中的值类型不会在赋值的时候去复制，而是在修改的时候才会去复制
 
 9. 如何声明一个只能被类conform的protocol
 protocol MyProtocol: class
 
 10. defer使用场景？
 多个defer，后加入的先执行
 
 11. String与NSString的关系和区别
 String是值类型，NSString是引用类型
 能够相互转换
 
 12. 为什么数组越界会crash，而字典取值时，没有对应值返回nil，而不会crash
 
 13. 这段代码有没有问题？
 var mutableArray = [1,2,3]
 for _ in mutableArray {
   mutableArray.removeLast()
 }
 空数组不会被遍历，所以没问题
 
 14. associatedType的作用？
 即protocol使用的泛型，实现协议时，可以使用typealias指定为特定类型，或者自动推断，或者使用泛型，或者使用where限定类型
 
 15. 什么时候使用final
 final用于限制重写和继承
 如果是限制某一个属性的重写，则在属性前加final
 如果是限制某一个类的继承，则在类前加final
 
 16. public和open的区别
 两者都用于在模块中声明需要对外界暴露的接口
 public修饰的类不能继承
 open修饰的类可以继承
 
 17. 声明一个只有参数没有返回值的闭包的别名
 typealias MyBlock = (String) -> Void
 let myBlock: MyBlock = { (str) in
 }
 
 18. Self的使用场景
 Self通常在协议中使用，用来表示实现者或者实现者的子类类型
 protocol MyProtocol {
    func doSomething() -> Self
 }
 struct中实现这个协议
 func doSomething() -> MyStruct
 class中实现这个协议
 https://swifter.tips/use-self/
 
 19. throws和rethrows的用法和作用
 throws用在函数上，表示这个函数会抛出错误
 有两种情况会导致函数有错误抛出，1. 直接使用throw抛出错误 2. 使用try但并没有catch
 rethrows一般用在参数中有抛出异常的函数的情况，用于传递异常，它自己所在的函数不会抛出异常
 
 20. 观察者模式，为了解决什么问题？通过什么方案解决？iOS中的具体解决方案有哪些？
 
 21. https的连接过程
 
 22. swift哪些是值类型，哪些是引用类型？
 值类型：结构体、枚举、元组、数组、字符串、字典，每个实例都保存了一份独立的拷贝
 引用类型：类，每个实例共享一份数据来源
 什么时候使用值类型：希望==比较实例数据时，希望拷贝保持独立时，数据被多线程使用时
 什么使用引用类型：希望==比较实例身份时，希望是一个可变对象时
 
 23. swift中闭包问题
 swift中的闭包捕获临时变量时，如果闭包中声明[foo]，表示捕获这个临时变量，后续的修改不会影响这个值，
 如果闭包中没有任何声明，则代表foo为引用类型，后续的修改会影响闭包中的值
 
 24. swift与oc中的常量的区别
 let number: Int = 0
 const Int number = 0;
 const代表这个值是编译时确定的，
 而let只是代表这个值被赋值后不能修改，是runtime时确定的
 
 25. 一个Sequence(序列) 的索引是不是从0开始的？
 不一定，根据自己的实现
 
 26. 数组都实现了哪些协议？
 MutableCollection，实现了数组的修改能力a[0] = 1
 ExpressibleByArrayLiteral，实现了数组可以从字面量初始化的能力[1, 2, 3]
 
 27. 如何自定义模式匹配？
 https://swifter.tips/pattern-match/
 
 28. autoclosure的作用？
 自动将表达式封装为闭包
 
 29. 编译选择 whole module optmization 优化了什么?
 https://www.jianshu.com/p/8dbf2bb05a1c
 
 30. struct中的mutating有什么用？
 struct Person  {
    var name: String  {
        mutating get  {
         return store
         }
      }
 }
 让不可变对象无法访问name属性
 
 31. Swift如何让自定义对象支持字面量初始化
 ExpressibleByArrayLiteral 可以由数组形式初始化
 ExpressibleByDictionaryLiteral 可以由字典形式初始化
 ExpressibleByNilLiteral 可以由nil 值初始化
 ExpressibleByIntegerLiteral 可以由整数值初始化
 ExpressibleByFloatLiteral 可以由浮点数初始化
 ExpressibleByBooleanLiteral 可以由布尔值初始化
 ExpressibleByUnicodeScalarLiteral
 ExpressibleByExtendedGraphemeClusterLiteral
 ExpressibleByStringLiteral

 32. swift中inout的作用
 swift中除了类是引用传递外，其他类型都是值传递，
 如果我们希望在函数中对原值进行修改，就需要加上inout参数
 
 33. swift中dynamic的作用
 swift中的属性是在编译时确定的，为了使用动态派发的特性（比如KVC、KVO等），就需要在属性前添加dynamic这个关键字，
 比如，dynamic var foo: String
 
 34. 深入理解swift的派发机制
 https://juejin.cn/post/6847009771845845006
 
 */

/**
 1、Swift中struct和class有什么区别？
 2、Swift中的方法调用有哪些形式？
 3、Swift和OC有什么区别？
 4、从OC向Swift迁移的时候遇到过什么问题？
 5、怎么理解面向协议编程？
 */
/*
 1. struct：值类型、不可继承、栈区
 class：引用类型、可继承、堆区
 2. 直接派发：CPU直接按照函数地址调用，静态调用
 函数表派发：vtable/witness table在编译时被构建，相较于直接调用，多了两次读取工作--函数表读取和函数指针读取
 消息机制派发：swift也是使用Objc的运行时来实现消息派发
 我们考虑四种类型，struct、protocol、class、NSObject
 在声明中，除了struct是直接派发以外，protocol、class、NSObject都是函数表派发
 原理：protocol、class、NSObject都有继承/实现的功能，利用函数表才能有这种调用方法的动态性
 在extension中，struct、protocol均为直接派发，class和NSObject默认情况下也为直接派发，在用dynamic修饰时，会变为消息机制派发
 final：让函数变为直接派发，并且对runtime不可见
 dynamic: 能够让函数使用消息机制转发
 使用dynamic必须导入foundation，因为要用到NSObject和运行时。
 @objc + dynamic修饰extension中的函数时，可以让extension中的函数可以override
 
 这段代码表明了protocol的扩展中是直接派发，
 但如果protocol声明了这个方法，默认实现之后，会走函数表派发，执行结果会变为“结构体”
 protocol MyProtocol {
 }
 struct MyStruct: MyProtocol {
 }
 extension MyStruct {
     func extensionMethod() {
         print("结构体")
     }
 }
 extension MyProtocol {
     func extensionMethod() {
         print("协议")
     }
 }
  
 let myStruct = MyStruct()
 let proto: MyProtocol = myStruct
  
 myStruct.extensionMethod() // -> “结构体”
 proto.extensionMethod() // -> “协议”
 
 3. swift: 静态语言，更安全，语法精简，有命名空间，支持泛型、元组、高阶函数，速度更快，更适合函数式/响应式编程
 OC: 动态语言，没那么安全，语法冗长，无命名空间，不支持，速度略慢，面向对象编程
 
 4. https://juejin.cn/post/6844904078166720520
 
 5. ref: https://onevcat.com/2016/11/pop-cocoa-1/
 OOP有三大困境，
 动态派发的安全性：方法的执行在运行时，报错也是在执行的时候
 横切关注点：某个方法（关注点）处于两条不同的继承链的横切面上
 菱形缺陷：多继承中，两个父类都实现了同样的方法
 POP基本解决了这三个问题
 */

/**
 Extension在swift和OC的区别？
 */
