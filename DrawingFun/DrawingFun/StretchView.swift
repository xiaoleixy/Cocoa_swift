//
//  StretchView.swift
//  DrawingFun
//
//  Created by xiaolei3 on 15/3/2.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Cocoa

class StretchView: NSView {

    var path: NSBezierPath! = NSBezierPath()
    var image:NSImage?{
        didSet{
            downPoint = NSZeroPoint
            currentPoint = NSZeroPoint
            if let imageSize = image?.size
            {
                currentPoint.x = downPoint.x + imageSize.width
                currentPoint.y = downPoint.y + imageSize.height
            }
            self.setNeedsDisplayInRect(self.bounds)
        }
    }
    var opacity:Float = 0.5 {
        didSet {
           self.setNeedsDisplayInRect(self.bounds)
        }
    }
    
    var downPoint: NSPoint!
    var currentPoint: NSPoint!
    
    override init() {
        super.init()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        srandom(UInt32(time(UnsafeMutablePointer())))
        path.lineWidth = 3.0
        
        var p = self.randomPoint()
        path.moveToPoint(p)
        for i in 0..<15 {
            p = self.randomPoint()
            path.lineToPoint(p)
        }
        path.closePath()
        
        self.opacity = 1.0
        
        return self
    }
    
    func randomPoint() -> NSPoint
    {
        var result:NSPoint = NSPoint()
        let r = self.bounds
        result.x = r.origin.x + CGFloat(random() % Int(r.size.width))
        result.y = r.origin.y + CGFloat(random() % Int(r.size.height))
        max(10, 100)
        return result
    }
    
    func currentRect() -> NSRect
    {
       
        var minX = min(downPoint.x, currentPoint.x)
        var maxX = max(downPoint.x, currentPoint.x)
        
        var minY = min(downPoint.y, currentPoint.y)
        var maxY = max(downPoint.y, currentPoint.y)
        
        return NSMakeRect(minX, minY, maxX-minX, maxY-minY)
        

        
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
        
        let bounds = self.bounds
        NSColor.greenColor().set()
        NSBezierPath.fillRect(bounds)
        
        NSColor.whiteColor().set()
        path.stroke()
        
        if let imageN = self.image {
            var imageRect:NSRect = NSRect()
            imageRect.origin = NSZeroPoint
            imageRect.size = imageN.size
            let drawingRect = self.currentRect()
            image?.drawInRect(drawingRect, fromRect: imageRect, operation: NSCompositingOperation.CompositeSourceOver, fraction:CGFloat(self.opacity))
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        println("mouseDown: \(theEvent.clickCount)")
        
        let p = theEvent.locationInWindow
        downPoint = self.convertPoint(p, fromView: nil)
        currentPoint = downPoint
        self.setNeedsDisplayInRect(self.bounds)
        
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let p = theEvent.locationInWindow
        println("mouseDragged: \(NSStringFromPoint(p))")
        currentPoint = self.convertPoint(p, fromView: nil)
        self.autoscroll(theEvent)
        self.setNeedsDisplayInRect(self.bounds)
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let p = theEvent.locationInWindow
        println("mouseUp")
        currentPoint = self.convertPoint(p, fromView: nil)
        self.setNeedsDisplayInRect(self.bounds)
        
    }
}
