//
//  AppComponent.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

class AppComponent{
    public static let instance = AppComponent()
    private var watchConnectivityController: WatchConnectivityController?
    private var notificationController: NotificationController?
    private var healthController: HealthController?
    private var dataController: DataController?
    
    private init(){}
    

    public func getWatchConnectivityController() -> WatchConnectivityController{
        if(watchConnectivityController == nil){
            watchConnectivityController = WatchConnectivityController()
        }
        return watchConnectivityController!
    }
    
    public func getNotificationController() -> NotificationController{
        if(notificationController == nil){
            notificationController = NotificationController()
        }
        return notificationController!
    }
    
    public func getHealthController() -> HealthController{
        if(healthController == nil){
            healthController = HealthController()
        }
        return healthController!
    }
    
    public func getDataController() -> DataController{
        if(dataController == nil){
            dataController = DataController()
        }
        return dataController!
    }
}
