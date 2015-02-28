//
//  PreferenceController.swift
//  RaiseMan
//
//  Created by xiaolei3 on 15/2/27.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

class PreferenceController: NSWindowController {

    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var checkbox: NSButton!
    override init() {
        super.init()
    }
    override init(window: NSWindow?) {
        super.init(window: window)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        colorWell.color = PreferenceController.preferenceTableBgColor()
        checkbox.state = NSUserDefaults.standardUserDefaults().integerForKey(BNREmptyDocKey)
        
        
    }

    @IBAction func changeBackgroundColor(sender: AnyObject) {
        let color = colorWell.color
        println("Color changed \(color)")
        PreferenceController.setPreferenceTableBgColor(color)
       
        NSNotificationCenter.defaultCenter().postNotificationName(BNRColorChangedNotification, object: self, userInfo:["color": color])
    }
    
    @IBAction func changeNewEmptyDoc(sender: AnyObject) {
        let state = checkbox.state 
        println("Checkbox changed \(state)")
        PreferenceController.setPreferenceEmptyDoc(Bool(state))
    }
    
    class func preferenceTableBgColor () -> NSColor
    {
        let colorAsData = NSUserDefaults.standardUserDefaults().objectForKey(BNRTableBgColorKey) as NSData
        return NSKeyedUnarchiver.unarchiveObjectWithData(colorAsData) as NSColor
    }
    
    class func setPreferenceTableBgColor(color: NSColor)
    {
       let colorAsData = NSKeyedArchiver.archivedDataWithRootObject(color)
        NSUserDefaults.standardUserDefaults().setObject(colorAsData, forKey: BNRTableBgColorKey)
    }
    
    class func preferenceEmptyDoc () -> Bool
    {
       return NSUserDefaults.standardUserDefaults().boolForKey(BNREmptyDocKey)
    }
    
    class func setPreferenceEmptyDoc (emptyDoc: Bool)
    {
        NSUserDefaults.standardUserDefaults().setBool(emptyDoc, forKey: BNREmptyDocKey)
    }
}
