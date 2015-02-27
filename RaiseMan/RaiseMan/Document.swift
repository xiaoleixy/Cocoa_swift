//
//  Document.swift
//  RaiseMan
//
//  Created by michael on 15/2/14.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

//忘记加前缀了, 看着这不要有疑惑 就是RMDocument
class Document: NSDocument {
    
    @objc(employees)
    var employees:[Person] = [Person]() {
        willSet {
            for person in employees {
                self.stopObservingPerson(person as Person)
            }
        }
        didSet {
            for person in employees {
                self.startObservingPerson(person as Person)
            }
        }
    }
    
    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var employeeController: NSArrayController!
    
    private var RMDocumentKVOContext = 0
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    
    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    
    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
//        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//        return nil
       
        
        //保存
        tableView.window?.endEditingFor(nil)
        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }
    
    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
        if let newArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Person] {
            self.employees = newArray
            return true
        }else
        {
            outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
            return false
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if (context != &RMDocumentKVOContext)
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        let undo = self.undoManager
        var oldValue: AnyObject? = change[NSKeyValueChangeOldKey]
        
        undo?.prepareWithInvocationTarget(self).changeKeyPath(keyPath, ofObject: object, toValue: oldValue!)
        undo?.setActionName("Edit")
    }
    
    @IBAction func onCheck(sender: AnyObject) {
        println(self.employees)
    }
    
    @IBAction func createEmployee(sender: AnyObject)
    {
        let w: NSWindow = self.tableView.window!
        //准备结束正在发生的编辑动作
        let editingEnded = w.makeFirstResponder(w)
        
        if (!editingEnded)
        {
            println("Unable to end editing")
            return
        }
        
        let undo = self.undoManager
        
        if undo?.groupingLevel > 0 {
            undo?.endUndoGrouping()
            undo?.beginUndoGrouping()
        }
        
        let p = self.employeeController.newObject() as Person
        
        self.employeeController.addObject(p)
        //重新排序
        self.employeeController.rearrangeObjects()
        //排序后的数组
        var a = self.employeeController.arrangedObjects as NSArray
        
        let row = a.indexOfObjectIdenticalTo(p)
        
        self.tableView.editColumn(0, row: row, withEvent: nil, select: true)
        
    }
    
    
    func startObservingPerson(person: Person)
    {
        person.addObserver(self, forKeyPath: "personName", options: NSKeyValueObservingOptions.Old, context: &RMDocumentKVOContext)
        person.addObserver(self, forKeyPath: "expectedRaise", options: NSKeyValueObservingOptions.Old, context: &RMDocumentKVOContext)
    }
    func stopObservingPerson(person: Person)
    {
        person.removeObserver(self, forKeyPath: "personName", context: &RMDocumentKVOContext)
        person.removeObserver(self, forKeyPath: "expectedRaise", context: &RMDocumentKVOContext)
    }
    
    func changeKeyPath(keyPath:NSString, ofObject obj: AnyObject, toValue newValue:AnyObject)
    {
        obj.setValue(newValue, forKeyPath: keyPath)
    }

    func insertObject(p: Person, inEmployeesAtIndex index: Int){
        println("adding \(p) to \(self.employees)")
        let undo = self.undoManager
        undo?.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(index)
        
        if (false == undo?.undoing) {
            undo?.setActionName("Add Person")
        }
        
        self.employees.insert(p, atIndex: index)
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let p: Person = self.employees[index] as Person
        println("removing \(p) to \(self.employees)")
        let undo = self.undoManager
        
        undo?.prepareWithInvocationTarget(self).insertObject(p, inEmployeesAtIndex: index)
        
        if (false == undo?.undoing) {
            undo?.setActionName("Remove Person")
        }
        
        self.employees.removeAtIndex(index)
        
    }
}

