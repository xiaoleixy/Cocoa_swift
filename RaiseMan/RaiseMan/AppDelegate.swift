//
//  AppDelegate.swift
//  RaiseMan
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa
let BNRTableBgColorKey = "BNRTableBackgroundColor"
let BNREmptyDocKey = "BNREmptyDocumentFlag"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var preferenceController: PreferenceController = PreferenceController(windowNibName: "Preferences")

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldOpenUntitledFile(sender: NSApplication) -> Bool {
        return PreferenceController.preferenceEmptyDoc()
    }
    @IBAction func showPreferencePanel(sender: AnyObject) {
        preferenceController.showWindow(self)
    }

    override class func initialize(){
        let defaultValues = NSMutableDictionary()
        let colorAsData = NSKeyedArchiver.archivedDataWithRootObject(NSColor.yellowColor())
        defaultValues.setObject(colorAsData, forKey: BNRTableBgColorKey)
        defaultValues.setObject(Bool(true), forKey: BNREmptyDocKey)
        
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultValues)
    }
    
    
}

