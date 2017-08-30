//
//  AppDelegate.swift
//  HappyTrack
//
//  Created by Martin Weber on 31.07.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?
    let watchConnectivityController = AppComponent.instance.getWatchConnectivityController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //----- Set Up UI -------
        self.setUpAppearance()

        //----- INIT WCSession
        watchConnectivityController.iniSession(delegate: self)
        
        //GET Permission Notifications
        AppComponent.instance.getNotificationController().initNotificationSetupCheck()
        
        
        //GET Permission HealthStore
        AppComponent.instance.getHealthController().enableHealthKit(completion: nil)
        
        //----- CHECK IF first Start
        let userDefaults = UserDefaults()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if(!userDefaults.bool(forKey: Constants.General.onboardingApp.key())){
            //int Values for First Start
            AppComponent.instance.getDataController().setDeftaultValues()
            
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "OnBoardingScreen")
        }else{
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "StartAppScreen")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NotificationCenter.default.post(name: NSNotification.Name(Constants.General.appDidEnterBackground.key()), object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //WCSession Delegate
    
    /**
        Receive Data
    */
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let date = userInfo[Constants.TrackValues.date.key()] as? Date,
            let context = userInfo[Constants.TrackValues.conetxt.key()] as? String,
            let feeling = userInfo[Constants.TrackValues.feeling.key()] as? String,
            let ownBehavior = userInfo[Constants.TrackValues.ownBehavior.key()] as? String,
            let otherBehavior = userInfo[Constants.TrackValues.otherBehavior.key()] as? String,
            let didSport = userInfo[Constants.TrackValues.didSport.key()] as? Bool,
            let minPuls = userInfo[Constants.TrackValues.minPuls.key()] as? Int,
            let maxPuls = userInfo[Constants.TrackValues.maxPuls.key()] as? Int,
            let countSteps = userInfo[Constants.TrackValues.stepCount.key()] as? Int{
            
            let trackDataHandler = AppComponent.instance.getTrackDataController()
            
            let calendar = Calendar.current
            let dateFormatDay = DateFormatter()
            dateFormatDay.dateFormat = "dd.MM.yyyy"
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            var stringMinutes = String(minutes)
            if(minutes < 10){
                stringMinutes = "0" + stringMinutes
            }
            var stringHours = String(hour)
            if(hour < 10){
                stringHours = "0" + stringHours
            }
            
            let trackDataTime = stringHours + ":" + stringMinutes
            let trackDataDate = dateFormatDay.string(from: date)
            
            let trackDatatEntity = TrackDataEntity(realDate: date,date: trackDataDate, time: trackDataTime, context: context, feeling: feeling, ownBehavior: ownBehavior, otherBehavior: otherBehavior, didSport: didSport, minPuls: minPuls, maxPuls: maxPuls, stepCount: countSteps)
            
            trackDataHandler.addTrackData(trackData: trackDatatEntity)
        }
    }
    
    /**
        Receive Message
    */
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    /**
        Receive Context
    */
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        
    }
    func sessionDidBecomeInactive(_ session: WCSession){
        
    }
    func sessionDidDeactivate(_ session: WCSession){
        
    }
    
    //OWN FUNCTIONS
    
    /**
        Sets the main appearance of the App
    */
    private func setUpAppearance(){
        let myAppColor = AppColor()
        
        //Button and Link Color
        self.window?.tintColor = myAppColor.primaryColor
        
        //Navigation Bar
        UINavigationBar.appearance().tintColor = myAppColor.textColorLight
        UINavigationBar.appearance().barTintColor = myAppColor.primaryColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: myAppColor.textColorLight]
        
        //Naviagtion Bar Shadow
        UINavigationBar.appearance().castShadow = ""
        
        //Text Color
        //UILabel.appearance().textColor = myAppColor.textColorDark
        
        //Status Bar
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Show Statusbar
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
    }


}

