//
//  SettingViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 15.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit
import ActionSheetPicker_3_0


class SettingsViewController: UITableViewController{
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputLastname: UITextField!
    @IBOutlet weak var labelNotificationFrom: UILabel!
    @IBOutlet weak var labelNotificationTo: UILabel!
    @IBOutlet weak var labelNotificationInterval: UILabel!
    @IBOutlet weak var switchNotification: UISwitch!
    
    var NotificationSettingsChange = false
    lazy var notificationCenter: NotificationCenter = {
        return NotificationCenter.default
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        notificationCenter.addObserver(forName: NSNotification.Name(Constants.General.appDidEnterBackground.key()), object: nil, queue: nil) { _ in
            print("TEST")
            if(self.NotificationSettingsChange){
                self.notifyUserNotificaionCange()
                self.NotificationSettingsChange = false
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(self.NotificationSettingsChange){
            self.notifyUserNotificaionCange()
            self.NotificationSettingsChange = false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (indexPath as NSIndexPath)
        
        if(index.section == 0){ //Secetion Genereal
            if(index.row == 0){ //Name
                inputName.becomeFirstResponder()
            }else if(index.row == 1){ //Lastname
                inputLastname.becomeFirstResponder()
            }
        }else if(index.section == 1){ //Secction Notification
            self.dismissKeyboard()
            switch index.row{
                case 1: showPickerFrom(sender: tableView, indexPath: indexPath)
                break
                case 2: showPickerTo(sender: tableView, indexPath: indexPath)
                break
                case 3: showPickerEvery(sender: tableView, indexPath: indexPath)
                break
                default: break //Notihng

            }
        }
    }
    
    @IBAction func changeName(_ sender: UITextField) {
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            shareDefaults.set(sender.text, forKey: Constants.Person.name.key())
        }
        sendNameToWatch()
    }
    @IBAction func changeLastname(_ sender: UITextField) {
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            shareDefaults.set(sender.text, forKey: Constants.Person.last_name.key())
        }
        sendNameToWatch()
    }
    @IBAction func changeNotificationOn(_ sender: UISwitch) {
        let userDefaults = UserDefaults()
        userDefaults.set(sender.isOn, forKey: Constants.RegisterLocalNotification.on.key())
        
        registerNotificationOnWatch()
    }
    
    private func showPickerFrom(sender: UITableView, indexPath: IndexPath){
        var hourArray = [Int]()
        for index in 0...22{
            hourArray.append(index)
        }
        let picker = ActionSheetMultipleStringPicker(title: "From", rows: [
            hourArray,
            [":00"],
            ], initialSelection: [UserDefaults().integer(forKey: Constants.RegisterLocalNotification.from.key()),0], doneBlock: {
                picker, indexes, values in
                
                UserDefaults().set(hourArray[indexes![0] as! Int], forKey: Constants.RegisterLocalNotification.from.key())
                self.updateUI()
                self.registerNotificationOnWatch()
                
                sender.deselectRow(at: indexPath, animated: true)
                return
        }, cancel: { ActionMultipleStringCancelBlock in
            sender.deselectRow(at: indexPath, animated: true)
            return
        }, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    
    private func showPickerTo(sender: UITableView, indexPath: IndexPath){
        let from = UserDefaults().integer(forKey: Constants.RegisterLocalNotification.from.key()) + 1
        var hourArray = [Int]()
        
        for index in from...23{
            hourArray.append(index)
        }
        let picker = ActionSheetMultipleStringPicker(title: "From", rows: [
            hourArray,
            [":00"],
            ], initialSelection: [0,0], doneBlock: {
                picker, indexes, values in
                
                UserDefaults().set(hourArray[indexes![0] as! Int], forKey: Constants.RegisterLocalNotification.to.key())
                self.updateUI()
                self.registerNotificationOnWatch()
                
                sender.deselectRow(at: indexPath, animated: true)
                return
        }, cancel: { ActionMultipleStringCancelBlock in
            sender.deselectRow(at: indexPath, animated: true)
            return
        }, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    
    private func showPickerEvery(sender: UITableView, indexPath: IndexPath){
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
                self.registerNotificationOnWatch()
                
                sender.deselectRow(at: indexPath, animated: true)
                return
        }, cancel: { ActionMultipleStringCancelBlock in
            sender.deselectRow(at: indexPath, animated: true)
            return
        }, origin: sender)
        
        picker?.toolbarButtonsColor = AppColor().primaryColor
        picker?.show()
    }
    
    private func updateUI(){
        let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key())
        let userDefaults = UserDefaults()
        
        
        inputName.text = shareDefaults?.string(forKey: Constants.Person.name.key())
        inputLastname.text = shareDefaults?.string(forKey: Constants.Person.last_name.key())
        
        switchNotification.isOn = userDefaults.bool(forKey: Constants.RegisterLocalNotification.on.key())
        labelNotificationFrom.text = userDefaults.string(forKey: Constants.RegisterLocalNotification.from.key())! + ":00"
        labelNotificationTo.text = userDefaults.string(forKey: Constants.RegisterLocalNotification.to.key())! + ":00"
        labelNotificationInterval.text = userDefaults.string(forKey: Constants.RegisterLocalNotification.interval.key())! + " Hours"
    }
    
    private func sendNameToWatch(){
        let data = AppComponent.instance.getDataController().getDataSendPerson()
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
    
    private func registerNotificationOnWatch(){
        self.NotificationSettingsChange = true
        let data = AppComponent.instance.getDataController().getDataSendRegisterNotification()
        AppComponent.instance.getWatchConnectivityController().sendData(data: data) { (success, errMsg) in
            if(!success){
                print(errMsg)
            }
        }
    }
    
    private func notifyUserNotificaionCange(){
        let userDefaults = UserDefaults()
        
        let textFrom = "From " + userDefaults.string(forKey: Constants.RegisterLocalNotification.from.key())! + ":00"
        let textTo = " to " + userDefaults.string(forKey: Constants.RegisterLocalNotification.to.key())! + ":00"
        let textEvery = " every " + userDefaults.string(forKey: Constants.RegisterLocalNotification.interval.key())! + " Hours"

        let textReminder = "Remeinder:  " + textFrom + textTo + textEvery
        let data = [
            Constants.PushLocalNotification.identifier.key(): "NotificationChange",
            Constants.PushLocalNotification.title.key(): "Setup Reminder",
            Constants.PushLocalNotification.body.key(): textReminder
        ]
        
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
}
