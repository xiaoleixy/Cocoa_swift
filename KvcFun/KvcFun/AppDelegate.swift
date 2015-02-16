//
//  AppDelegate.swift
//  KvcFun
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var fido: Int = 0

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func incrementFido(sender: AnyObject) {
        self.willChangeValueForKey("fido")
        self.fido = self.fido + 1
        self.didChangeValueForKey("fido")
    }

}

