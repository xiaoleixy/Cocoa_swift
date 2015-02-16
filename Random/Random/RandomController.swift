//
//  RandomController.swift
//  Random
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

class RandomController: NSObject {

    @IBOutlet weak var textField: NSTextField!
    
    @IBAction func seed(sender: AnyObject) {
        srandom(UInt32(time(nil)))
        textField.stringValue = "Generator seeded"
    }
    
    @IBAction func generate(sender: AnyObject) {
       var generated = Int(random()%100 + 1)
       textField.stringValue = String(generated)
    }
    
    override func awakeFromNib() {
        let now = NSDate()
        textField.objectValue = now
    }
    
}
