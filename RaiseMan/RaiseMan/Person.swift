//
//  Person.swift
//  RaiseMan
//
//  Created by michael on 15/2/16.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Foundation

//@objc() swift 对象转成 Interface 对象
@objc(Person)
class Person: NSObject {
    //用!会报错，替换为赋初值
//    var personName: String!
//    var expectedRaise: Float!
    
    var personName: String = ""
    var expectedRaise: Float = 0
    
    override init(){
        super.init()
        self.personName = "New Person"
        self.expectedRaise = 0.05
    }
    
    func customDescription() -> String {
        return "personName : " + self.personName + ", expectedRasise : \(self.expectedRaise)"
    }
    
    override var description: String {
        return customDescription()
    }
}
