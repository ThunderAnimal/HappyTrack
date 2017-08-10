//
//  WatchSessionController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchConnectivity
import WatchKit

protocol ObserveSession {
    func messageReceive(data:Any)
}

class WatchSessionController: NSObject,WCSessionDelegate{
    // Instantiate the Singleton
    static let sharedManager = WatchSessionController()
    
    public var observer: ObserveSession!
    private override init() {
        super.init()
    }
    
    // Keep a reference for the session,
    // which will be used later for sending / receiving data
    private let session = WCSession.default()
    
    // Activate Session
    // This needs to be called to activate the session before first use!
    func startSession() {
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let message = message["username"]{
            print(message)
            if(observer != nil){
                observer.messageReceive(data: message)
            }
            WKInterfaceDevice.current().play(WKHapticType.notification)
        }
    }
    func sendMessage(key : String, data: Any){
        let message = [key: data]
        session.sendMessage(message, replyHandler: { (replyMessage: [String : Any]) in
            //HANDLE REPLY
        }) { (error) in
            print(error.localizedDescription)
            return
        }
        
    }
}
