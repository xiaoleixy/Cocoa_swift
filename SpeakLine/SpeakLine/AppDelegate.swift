//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSSpeechSynthesizerDelegate, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var stopButton: NSButtonCell!
    @IBOutlet weak var speakButton: NSButton!
    
    @IBOutlet weak var tableView: NSTableView!
    
    
    var speechSynth: NSSpeechSynthesizer! = NSSpeechSynthesizer(voice: nil)
    
    var voices : NSArray!
    //重载父类构造方法
    override init() {
        super.init()
        self.speechSynth.delegate = self
        self.voices = NSSpeechSynthesizer.availableVoices()
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func sayIt(sender: AnyObject) {
        let string = self.textField.stringValue
        self.speechSynth.startSpeakingString(string)
        self.speakButton.enabled = false
        self.stopButton.enabled = true
        self.tableView.enabled = false
    }
    
    @IBAction func stopIt(sender: AnyObject) {
        self.speechSynth.stopSpeaking()
    }
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        self.speakButton.enabled = true
        self.stopButton.enabled = false
        self.tableView.enabled = true
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.voices.count
    }
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let v: String = self.voices.objectAtIndex(row) as String
        let dict: NSDictionary = NSSpeechSynthesizer.attributesForVoice(v)!
        return dict.objectForKey(NSVoiceName)
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = self.tableView.selectedRow
        if row == -1 {
            return
        }
        let selectVoice = self.voices.objectAtIndex(row) as String
        self.speechSynth.setVoice(selectVoice)
    }
    
}

