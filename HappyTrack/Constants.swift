//
//  Constants.swift
//  HappyTrack
//
//  Created by Martin Weber on 03.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

public enum Constants{
    public static func bundle () -> String{
        return "de.mweber.uni.HappyTrack"
    }
    
    public enum General: Int {
        case onboardingApp
        
        public func key() -> String{
            switch self {
            case .onboardingApp:
                return "FIRST_START"
            }
        }
    }
    
    public enum AppGroups: Int {
        case person_name
        
        public func key() -> String{
            switch self {
            case .person_name:
                return "group.de.mweber.uni"
            }
        }
    } 
    
    public enum Person: Int {
        case name, last_name
        
        public func key() -> String{
            switch self {
            case .name:
                return "NAME"
            case .last_name:
                return "LAST_NAME"
            }
        }
    }
    
    public enum WatchNotification: Int {
        case contextReceived,  dataAdded
        
        public func key() -> String{
            switch self {
            case .contextReceived:
                return "NotificationContextReceived"
            case .dataAdded:
                return "NotificationWatchDataAdded"
            }
        }
    }
    
    public enum RegisterLocalNotification: Int {
        case on, from, to, interval
        public func key() -> String {
            switch self {
            case .on:
                return "NOTIFICATION_ON"
            case .from:
                return "NOTIFICATION_FROM"
            case .to:
                return "NOTIFICATION_TO"
            case .interval:
                return "NOTIFICATION_INTERVAL"
                
            }
        }
    }
    public enum PushLocalNotification: Int {
        case identifier, title, body
        public func key() -> String {
            switch self {
            case .identifier:
                return "IDENTIFIER"
            case .title:
                return "TITLE"
            case .body:
                return "BODY"
            }
        }
    }
    
    public enum NotificationCategory: Int{
        case happytrack_needed, general
        public func indentifier() -> String{
            switch self {
            case .happytrack_needed:
                return "HAPPYTRACK_NEEDED"
            case .general:
                return "GENERAL"
            }
        }
    }
    
    public enum NotificationAction: Int{
        case track_action
        public func indentifier() -> String{
            switch self {
            case .track_action:
                return "TRACK_ACTION"
            }
        }
    }
}
