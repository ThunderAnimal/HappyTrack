//
//  StartViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class OnboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func finishOnBaording(){
        UserDefaults().set(true, forKey: Constants.General.onboardingApp.key())
        
        self.sendUserDataToWatch()
        self.sendRegisterNotificationToWatch()
        self.sendWelcomeMessageToWatch()
    }
    
    private func sendUserDataToWatch (){
        let data = AppComponent.instance.getDataController().getDataSendPerson()
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
    
    private func sendRegisterNotificationToWatch(){
        let data = AppComponent.instance.getDataController().getDataSendRegisterNotification()
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
    
    private func sendWelcomeMessageToWatch(){
        let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key())
        
        let data = [
            Constants.PushLocalNotification.identifier.key(): "WELCOME",
            Constants.PushLocalNotification.title.key(): "Hey " + shareDefaults!.string(forKey: Constants.Person.name.key())!,
            Constants.PushLocalNotification.body.key(): "Welcome to HappyTrack. You are AWESOME!"]
        
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
}
