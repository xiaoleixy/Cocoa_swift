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
class Person: NSObject , NSCoding{
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
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.personName = decoder.decodeObjectForKey("personName") as String
        self.expectedRaise = decoder.decodeObjectForKey("expectedRaise") as Float
    }
    
    func customDescription() -> String {
        return "personName : " + personName + ", expectedRasise : \(expectedRaise)"
    }
    
    override var description: String {
        return customDescription()
    }
    
    override func setNilValueForKey(key: String) {
        if key == "expectedRaise" {
           self.expectedRaise = 0.0
        }else {
            super.setNilValueForKey(key)
        }
    }
    func encodeWithCoder(coder: NSCoder) {
            coder.encodeObject(personName, forKey: "personName")
            coder.encodeObject(expectedRaise, forKey: "expectedRaise")
    }
    
}
