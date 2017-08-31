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
        case onboardingApp, appDidEnterBackground
        
        public func key() -> String{
            switch self {
            case .onboardingApp:
                return "FIRST_START"
            case .appDidEnterBackground:
                return "APP_DID_ENTER_BACKGOUND"
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
    public enum WatchInputSuggestions: Int{
        case context
        public func key() -> String{
            switch self{
            case .context: return "SUGGESTION_CONTEXT"
            }
        }
    }
    
    public enum TrackValues: Int{
        case date, conetxt, feeling, ownBehavior, otherBehavior, didSport, minPuls, maxPuls, stepCount
        public func key() -> String{
            switch self{
            case .date: return "TRACK_DATE"
            case .conetxt: return "TRACK_CONTEXT"
            case .feeling: return "TRACK_FEELING"
            case .ownBehavior: return "TRACK_OWNBEHAVIOR"
            case .otherBehavior: return "TRACK_OTHERBEHAVIOR"
            case .didSport: return "TRACK_DIDSPORT"
            case .minPuls: return "TRACK_MINPULS"
            case .maxPuls: return "TRACK_MAXPULS"
            case .stepCount: return "TRACK_STEPCOUNT"
            }
        }
    }
    
    public enum TrackContext: Int{
        case work, home, doctor, sport, relax, music, television, game, read,family,friends, shopping, other
        
        public func key() -> String{
            switch self {
            case .work: return "work"
            case .home: return "home"
            case .doctor: return "doctor"
            case .sport: return "sport"
            case .relax: return "releax"
            case .music: return "music"
            case .television: return "television"
            case .game: return "game"
            case .read: return "read"
            case .family: return "family"
            case .friends: return "friends"
            case .shopping: return "shopping"
            case .other: return "other"
            default: return ""
            }
        }
    }
    
    public enum TrackFeeling: Int{
        case veryHappy, happy, smiling, confused, sad, unhappy, anger
        
        public func key() -> String{
            switch self{
            case .veryHappy: return "very happy"
            case .happy: return "happy"
            case .smiling: return "smiling"
            case .confused: return "confused"
            case .sad: return "sad"
            case .unhappy: return "unhappy"
            case .anger: return "mad"
            }
        }
    }
    
    public enum TrackBehavior: Int{
        case open, friendyDominant, friendly, friendlyObsequious, close, hostileObsequios, hostile, hostileDominant
        
        public func key() -> String{
            switch self{
            case .open: return "open"
            case .friendyDominant: return "friendly dominant"
            case .friendly: return "friendly"
            case .friendlyObsequious: return "freindly obsequious"
            case .close: return "close"
            case .hostileObsequios: return "hostile obsequious"
            case .hostile: return "hostile"
            case .hostileDominant: return "hostile dominant"
            }
        }
    }
}
