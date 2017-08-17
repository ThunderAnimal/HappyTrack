//
//  OnBoardsNotificationViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 17.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class OnboardNotificationViewController: OnboardViewController {
    
    @IBOutlet weak var switchNotificationOn: UISwitch!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnEvery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.updateUI()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateUI(){
        let userDefaults = UserDefaults()
        
        switchNotificationOn.isOn = userDefaults.bool(forKey: Constants.RegisterLocalNotification.on.key())
        btnFrom.setTitle(userDefaults.string(forKey: Constants.RegisterLocalNotification.from.key())! + ":00", for: UIControlState.normal)
        btnTo.setTitle(userDefaults.string(forKey: Constants.RegisterLocalNotification.to.key())! + ":00", for: UIControlState.normal)
        btnEvery.setTitle(userDefaults.string(forKey: Constants.RegisterLocalNotification.interval.key())! + " Hours", for: UIControlState.normal)
    }

    @IBAction func clickButtonFrom(_ sender: UIButton) {
        var hourArray = [Int]()
        for index in 0...22{
            hourArray.append(index)
        }
        let picker = ActionSheetMultipleStringPicker(title: "From", rows: [
            hourArray,
            [":"],["00"],
            ], initialSelection: [UserDefaults().integer(forKey: Constants.RegisterLocalNotification.from.key()),0,0], doneBlock: {
                picker, indexes, values in
                
                UserDefaults().set(hourArray[indexes![0] as! Int], forKey: Constants.RegisterLocalNotification.from.key())
                self.updateUI()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return}, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    @IBAction func clickButtonTo(_ sender: UIButton) {
        let from = UserDefaults().integer(forKey: Constants.RegisterLocalNotification.from.key()) + 1
        var hourArray = [Int]()
        
        for index in from...23{
            hourArray.append(index)
        }
        let picker = ActionSheetMultipleStringPicker(title: "To", rows: [
            hourArray,
            [":00"],
            ], initialSelection: [0,0], doneBlock: {
                picker, indexes, values in
                
                UserDefaults().set(hourArray[indexes![0] as! Int], forKey: Constants.RegisterLocalNotification.to.key())
                self.updateUI()
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return}, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    @IBAction func clickButtonEvery(_ sender: UIButton) {
        var everyArray = [Int]()
        for index in 1...8{
            everyArray.append(index)
        }
        let picker = ActionSheetMultipleStringPicker(title: "Every", rows: [
            everyArray,
            ["Hours"],
            ], initialSelection: [UserDefaults().integer(forKey: Constants.RegisterLocalNotification.interval.key()) - 1,0], doneBlock: {
                picker, indexes, values in
                
                
                UserDefaults().set(everyArray[indexes![0] as! Int], forKey: Constants.RegisterLocalNotification.interval.key())
                self.updateUI()

                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    
    
}
