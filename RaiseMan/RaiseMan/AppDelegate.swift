//
//  AppDelegate.swift
//  RaiseMan
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var preferenceController: PreferenceController = PreferenceController(windowNibName: "Preferences")

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    @IBAction func showPreferencePanel(sender: AnyObject) {
        preferenceController.showWindow(self)
    }

}

