//
//  WatchSessionController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

class WatchConnectivityController: NSObject, WCSessionDelegate{
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    
    override init(){
        super.init()
    }
    
    /**
        Init Session
    */
    public func iniSession(){
        guard WCSession.isSupported() else{
            return
        }
        
        self.session?.delegate = self
        self.session?.activate()
        
    }
    
    /**
     Send Data to Watch --> Backgroudn Kommunikation, not neassary that the App runs on Watch
     */
    func sendData(key : String, data: Any,callback: @escaping (Bool, String) -> Void){
        let data = [key: data]
        self.sendData(data: data, callback: callback)
    }
    
    /**
        Send Data to Watch --> Backgroudn Kommunikation, not neassary that the App runs on Watch
    */
    func sendData(data: [String:Any],callback: @escaping (Bool, String) -> Void){
        guard let session = self.session else {
            callback(false, "WCSession is not iniialize")
            return
        }
        
        session.activate()
        if(session.isWatchAppInstalled == false){
            callback(false, "App is not installed on Apple Watch. Please installe the App")
            return
        }
        
        do{
            try session.updateApplicationContext(data)
    
            callback(true, "All Done.")
        } catch {
            callback(false, "Unable to send application context: \(error)")
            print(error)
        }
    }
    
    
    /**
        Send Message To Watch --> Direct Kommunikation, App need to runs on Watch
    */
    func sendMessage(key : String, data: Any, callback: @escaping (Bool, String) -> Void){
        
        let message = [key: data]
        
        guard  let session = self.session else {
            callback(false, "WCSession is not initialize")
            return
        }
        
        session.activate()
        if(!session.isPaired){
            callback(false, "Apple Watch not paired")
            return
        }
        if(session.isWatchAppInstalled == false){
            callback(false, "App is not installed on Apple Watch. Please installe the App")
            return
        }
        
        session.sendMessage(message, replyHandler: { (replyMessage: [String : Any]) in
            //HANDLE REPLY
        }) { (error) in
            callback(false, "Somthing went wrong. Cant send Message to Apple Watch")
            print(error.localizedDescription)
            return
        }
        
        callback(true, "All Done.")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        
    }
    func sessionDidBecomeInactive(_ session: WCSession){
        
    }
    func sessionDidDeactivate(_ session: WCSession){
        
    }
}
