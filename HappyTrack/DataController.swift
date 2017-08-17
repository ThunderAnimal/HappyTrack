//
//  DataController.swift
//  HappyTrack
//
//  Created by Martin Weber on 16.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
class DataController{
    public func setDeftaultValues() -> Void{
        let userDefaults = UserDefaults()
        userDefaults.set(true, forKey: Constants.RegisterLocalNotification.on.key())
        userDefaults.set(10, forKey: Constants.RegisterLocalNotification.from.key())
        userDefaults.set(22, forKey: Constants.RegisterLocalNotification.to.key())
        userDefaults.set(2, forKey: Constants.RegisterLocalNotification.interval.key())
    }
    
    public func getDataSendPerson() -> [String:Any]{
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            let data = [
                Constants.Person.name.key(): shareDefaults.string(forKey: Constants.Person.name.key())!,
                Constants.Person.last_name.key(): shareDefaults.string(forKey: Constants.Person.last_name.key())!,
                ]
            return data
        }else{
            return [String:String]()
        }
    }
    
    public func getDataSendRegisterNotification() -> [String: Any]{
        let userDefaults = UserDefaults()
        let data = [
            Constants.RegisterLocalNotification.on.key(): userDefaults.bool(forKey: Constants.RegisterLocalNotification.on.key()),
            Constants.RegisterLocalNotification.from.key(): userDefaults.integer(forKey: Constants.RegisterLocalNotification.from.key()),
            Constants.RegisterLocalNotification.to.key(): userDefaults.integer(forKey: Constants.RegisterLocalNotification.to.key()),
            Constants.RegisterLocalNotification.interval.key(): userDefaults.integer(forKey: Constants.RegisterLocalNotification.interval.key())
        ] as [String : Any]
        
        return data;
    }
}
