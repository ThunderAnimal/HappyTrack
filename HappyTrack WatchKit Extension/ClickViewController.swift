//
//  ClickViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import WatchKit
import Foundation


class ClickViewController: WKInterfaceController {

    @IBOutlet var tapGroup: WKInterfaceGroup!
    @IBOutlet var btnClick: WKInterfaceButton!

    let startSize = 10.0
    var currentSize: Double!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.currentSize = startSize
        self.setSize(size: CGFloat(startSize))
      
    }
    
    @IBAction func tapRecognized(_ sender: Any) {
        currentSize = currentSize + startSize
        //tapGroup.setBackgroundColor(UIColor.red)
        
        self.setSize(size: CGFloat(currentSize!))
    }

    @IBAction func clickButton() {
        currentSize = currentSize - startSize
        //tapGroup.setBackgroundColor(UIColor.green)
        
        self.setSize(size: CGFloat(currentSize!))
    }
 
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setSize(size:CGFloat){
        self.btnClick.setHeight(size)
        self.btnClick.setWidth(size)
    }
}

