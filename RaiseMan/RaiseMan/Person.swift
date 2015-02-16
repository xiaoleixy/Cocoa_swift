//
//  Person.swift
//  RaiseMan
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

class Person: NSObject {
    var personName: String!
    var expectedRaise: float!
    
    override init(){
        super.init()
        self.personName = "New Person"
        self.expectedRaise = 0.05
    }
}
