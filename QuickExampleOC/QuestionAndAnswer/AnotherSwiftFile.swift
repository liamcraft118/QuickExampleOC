//
//  AnotherSwiftFile.swift
//  QuickExampleOC
//
//  Created by Liam on 2021/5/6.
//

import Foundation

class AnotherSwiftClass {
    @objc dynamic func sayHi() {
        
    }
}

extension AnotherSwiftClass {
    @objc func sayYes() {
        
    }
}

class MySubClasss: AnotherSwiftClass {
    override func sayYes() {
    }
    
//    override func sayHi() {
//    }
}

extension MySubClasss {
    override func sayHi() {
        print("test")
    }
}
