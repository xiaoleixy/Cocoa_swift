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
    var personName: String!
    var expectedRaise: Float!
    
    override init(){
        super.init()
        self.personName = "New Person"
        self.expectedRaise = 0.05
    }
    
    func customDescription() -> String {
        return "personName : " + self.personName
//            + "\n" + "expectedRaise : " + String(self.expectedRaise)
    }
    
    override var description: String {
        return customDescription()
    }
}
