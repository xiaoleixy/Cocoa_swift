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
    }

    @IBAction func changeBackgroundColor(sender: AnyObject) {
        let color = colorWell.color
        println("Color changed \(color)")
    }
    @IBAction func changeNewEmptyDoc(sender: AnyObject) {
        let state = checkbox.state
        println("Checkbox changed \(state)")
    }
}
