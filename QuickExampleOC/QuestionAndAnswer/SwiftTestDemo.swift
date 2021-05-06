//
//  SwiftTestDemo.swift
//  QuickExampleOC
//
//  Created by Liam on 2021/4/25.
//

import UIKit

struct Point {
    var x, y: Double
    var z: Double = 0
}

class MySwiftClass: NSObject {
    var foo: String = ""
    
    @objc func start() {
        var p1 = Point(x: 0, y: 0)
        var p2: Int64 = Int64.max
        var p3: Int64 = Int64.max
        var p4 = Point(x: 0, y: 0)
        
        print("\(#file), \(#line), \(#column), \(#function), \(#dsohandle)")

        withUnsafePointer(to: &p1) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p2) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p3) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p4) { (p) in
            print(p)
        }
        
        print(MemoryLayout.size(ofValue: p1))
        print(MemoryLayout.size(ofValue: p2))
        print(MemoryLayout.size(ofValue: p3))
        print(MemoryLayout.size(ofValue: p4))
        
        doSomething()
    }
    
    private func doSomething() {
        var p1 = Point(x: 0, y: 0)
        var p2 = p1
        var p3 = p1
        var p4 = Point(x: 0, y: 0)
        p3.x = 2
        
        print("doSomething")
        withUnsafePointer(to: &p1) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p2) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p3) { (p) in
            print(p)
        }
        withUnsafePointer(to: &p4) { (p) in
            print(p)
        }
        
        print(MemoryLayout.size(ofValue: p1))
        print(MemoryLayout.size(ofValue: p2))
        print(MemoryLayout.size(ofValue: p3))
        print(MemoryLayout.size(ofValue: p4))

    }
}

/// 对这篇文章中使用struct来完成设计的体验
/// 关于绘制的功能，文章中是如下设计的
/// ref: https://www.raywenderlich.com/7320-getting-to-know-enum-struct-and-class-types-in-swift
protocol Drawable {
    func draw(with context: DrawingContext)
}

struct Circle: Drawable {
    var strokeWidth = 5
    var strokeColor = UIColor.red
    var fillColor = UIColor.blue
    var center = (x: 80.0, y: 160.0)
    var radius = 60.0
    
    func draw(with context: DrawingContext) {
        context.draw(self)
    }
}

protocol DrawingContext {
    func draw(_ circle: Circle)
}

/// 看到这里想必都会产生一些疑惑，这个代码看起来相互引用，总觉得有点奇怪
/// 接下来我们用“正向思维”来设计一下这个代码，我们先屡一下需求，我们想要能够画圆、画矩形，以后可能还想画其他形状，而且这些形状能够一起画出来
protocol MyDrawable {
    func draw(with context: MyDrawingContext)
}

protocol MyDrawingContext {
    func draw(drawable: MyDrawable)
}

class MyCircle: MyDrawable {
    func draw(with context: MyDrawingContext) {
    }
}

class MyRectangle: MyDrawable {
    func draw(with context: MyDrawingContext) {
    }
}
