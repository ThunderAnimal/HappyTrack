//
//  TrackInterfaceController.swift
//  HappyTrack
//
//  Created by Martin Weber on 19.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity
import HealthKit


class TrackInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {
    
    //Groups
    @IBOutlet var groupContext: WKInterfaceGroup!
    @IBOutlet var groupContextIcons: WKInterfaceGroup!
    @IBOutlet var groupContextList: WKInterfaceGroup!
    @IBOutlet var groupFeeling: WKInterfaceGroup!
    @IBOutlet var groupFeelingIcons: WKInterfaceGroup!
    @IBOutlet var groupFeelingList: WKInterfaceGroup!
    @IBOutlet var groupOwnBehavior: WKInterfaceGroup!
    @IBOutlet var groupOwnBehaviorIcons: WKInterfaceGroup!
    @IBOutlet var groupOwnBehaviorList: WKInterfaceGroup!
    @IBOutlet var groupOtherBehavior: WKInterfaceGroup!
    @IBOutlet var groupOtherBehaviorIcons: WKInterfaceGroup!
    @IBOutlet var groupOtherBehaviorList: WKInterfaceGroup!
    @IBOutlet var groupSport: WKInterfaceGroup!
    
    //Back Buttons
    @IBOutlet var btnBackFeeling: WKInterfaceButton!
    @IBOutlet var btnBackOwnBehavior: WKInterfaceButton!
    @IBOutlet var btnBackOtherBehavior: WKInterfaceButton!
    @IBOutlet var btnBackDidSport: WKInterfaceButton!
    
    //Context Buttons
    @IBOutlet var groupBtnWork: WKInterfaceGroup!
    @IBOutlet var groupBtnHome: WKInterfaceGroup!
    @IBOutlet var groupBtnDoctor: WKInterfaceGroup!
    @IBOutlet var groupBtnSport: WKInterfaceGroup!
    @IBOutlet var groupBtnReleax: WKInterfaceGroup!
    @IBOutlet var groupBtnMusic: WKInterfaceGroup!
    @IBOutlet var groupBtnTv: WKInterfaceGroup!
    @IBOutlet var groupBtnGame: WKInterfaceGroup!
    @IBOutlet var groupBtnRead: WKInterfaceGroup!
    @IBOutlet var groupBtnFamily: WKInterfaceGroup!
    @IBOutlet var groupBtnFriends: WKInterfaceGroup!
    @IBOutlet var groupBtnShopping: WKInterfaceGroup!
    
    //Feeling Buttons
    @IBOutlet var goupBtnVeryHappy: WKInterfaceGroup!
    @IBOutlet var goupBtnHappy: WKInterfaceGroup!
    @IBOutlet var goupBtnSmilling: WKInterfaceGroup!
    @IBOutlet var goupBtnConfused: WKInterfaceGroup!
    @IBOutlet var goupBtnSad: WKInterfaceGroup!
    @IBOutlet var goupBtnUnhappy: WKInterfaceGroup!
    @IBOutlet var goupBtnMad: WKInterfaceGroup!
    
    //Behavior own Buttons
    @IBOutlet var goupBtnOwnOpen: WKInterfaceGroup!
    @IBOutlet var goupBtnOwnHostileDominat: WKInterfaceGroup!
    @IBOutlet var goupBtnOwnFriendlyDominant: WKInterfaceGroup!
    @IBOutlet var goupBtnOwnHostile: WKInterfaceGroup!
    @IBOutlet var goupBtnFriendly: WKInterfaceGroup!
    @IBOutlet var groupBtnOwnHostileObsequious: WKInterfaceGroup!
    @IBOutlet var groupBtnOwnFriendlyObsequious: WKInterfaceGroup!
    @IBOutlet var groupBtnOwnClose: WKInterfaceGroup!
    
    //Behavior Other Buttons
    @IBOutlet var goupBtnOtherOpen: WKInterfaceGroup!
    @IBOutlet var goupBtnOtherHostileDominat: WKInterfaceGroup!
    @IBOutlet var goupBtnOtherFriendlyDominant: WKInterfaceGroup!
    @IBOutlet var goupBtnOtherHostile: WKInterfaceGroup!
    @IBOutlet var goupBtnOtherFriendly: WKInterfaceGroup!
    @IBOutlet var groupBtnOtherHostileObsequious: WKInterfaceGroup!
    @IBOutlet var groupBtnOtherFriendlyObsequious: WKInterfaceGroup!
    @IBOutlet var groupBtnOtherClose: WKInterfaceGroup!
    
    //Sport Buttons
    @IBOutlet var btnSportYes: WKInterfaceButton!
    @IBOutlet var btnSportNo: WKInterfaceButton!
    
    //Variables for getting Healtstore Data
    let healthStore = HKHealthStore()
    let heartRateUnit = HKUnit(from: "count/min")
    var workoutSession: HKWorkoutSession?
    var currenQuery : HKQuery?
    
    
    private var trackHelper: TrackHelper!
    
    private let adaptiveUI = AdaptivUI.shared
    
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        // Configure interface objects here.
        
        self.addIconButtonsToAdaptiveUI()
        self.addGroupsToAdaptiveUI()
        
        if(context as? String == "startTrack"){
            self.startTrack()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // ******** TAP/SWIPE/PRESS REcognizer
    @IBAction func tapView(_ sender: Any) {
        adaptiveUI.tapOnView()
    }
    //************************
  
    
    // ******** click BACK BUTTONS
    @IBAction func clickBackFeeling() {
        adaptiveUI.tapWithActionBack()
        self.switchGroup(hideGroup: groupFeeling, showGroup: groupContext)
        self.startTrackContext()
    }
    @IBAction func clickBackOwnBehavior() {
        adaptiveUI.tapWithActionBack()
        self.switchGroup(hideGroup: groupOwnBehavior, showGroup: groupFeeling)
        self.startTrackFeeling()
    }
    @IBAction func clickBackOtherBehavior() {
        adaptiveUI.tapWithActionBack()
        self.switchGroup(hideGroup: groupOtherBehavior, showGroup: groupOwnBehavior)
        self.startTrackOwnBehavior()
    }
    @IBAction func clickBackDidSport() {
        adaptiveUI.tapWithActionBack()
        self.switchGroup(hideGroup: groupSport, showGroup: groupOtherBehavior)
        self.startTrackDidSport()
    }
    //************************
    
    // ******** click Context BUTTONS
    @IBAction func clickContextWork() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.work.key())
    }
    @IBAction func clickContextHome() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.home.key())
    }
    @IBAction func clickContexDoctor() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.doctor.key())
    }
    @IBAction func clickContextSport() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.sport.key())
    }
    @IBAction func clickContextReleax() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.relax.key())
    }
    @IBAction func clickContextMusic() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.music.key())
    }
    @IBAction func clickContextTv() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.television.key())
    }
    @IBAction func clickContextGame() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.game.key())
    }
    @IBAction func clickContextRead() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.read.key())
    }
    @IBAction func clickContextFamilie() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.family.key())
    }
    @IBAction func clickContextFriends() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.friends.key())
    }
    @IBAction func clickContexShopping() {
        adaptiveUI.tapWithAction()
        self.trackContext(context: Constants.TrackContext.shopping.key())
    }
    @IBAction func clickContextOther() {
        adaptiveUI.tapWithAction()
        let userDefaults = UserDefaults()
        
        var suggestionsContext = userDefaults.stringArray(forKey: Constants.WatchInputSuggestions.context.key())
        if(suggestionsContext == nil){
            suggestionsContext = [String]()
        }
        
        self.presentTextInputController(withSuggestions: suggestionsContext, allowedInputMode: .plain) { (result) in
            if((result != nil) && (result?.count)! > 0){
                let string = (result as? [String])?.joined(separator: " ")
                self.trackContext(context: string!)
                
                //a new suggestion to list, if it not contains
                let res = suggestionsContext!.filter({ (suggestion) -> Bool in
                    if suggestion == string{
                        return true
                    }else{
                        return false
                    }
                })
                if !(res.count > 0){
                    suggestionsContext!.append(string!)
                    userDefaults.set(suggestionsContext, forKey: Constants.WatchInputSuggestions.context.key())
                }
                
            }
        }
    }
    //************************

    // ******** click Feeling BUTTONS
    @IBAction func clickFeelingVeryHappy() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.veryHappy.key())
    }
    @IBAction func clickFeelingHappy() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.happy.key())
    }
    @IBAction func clickFeelingSmiling() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.smiling.key())
    }
    @IBAction func clickFeelingConfused() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.confused.key())
    }
    @IBAction func clickFeelingSad() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.sad.key())
    }
    @IBAction func clickFeelingUnHappy() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.unhappy.key())
    }
    @IBAction func clickFeelingAnger() {
        adaptiveUI.tapWithAction()
        self.trackFeeling(feeling: Constants.TrackFeeling.anger.key())
    }
    //************************
    
    // ******** click OWN Behavior BUTTONS
    @IBAction func clickOwnBehaviorOpen() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.open.key())
    }
    @IBAction func clickOwnBehaviorFriendlyDominant() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendyDominant.key())
    }
    @IBAction func clickOwnBehaviorFriendly() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendly.key())
    }
    @IBAction func clickOwnBehaviorFriendlyObsequious() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendlyObsequious.key())
    }
    @IBAction func clickOwnBehaviorClose() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.close.key())
    }
    @IBAction func clickOwnBehaviorHostileObsequious() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostileObsequios.key())
    }
    @IBAction func clickOwnBehaviorHostile() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostile.key())
    }
    @IBAction func clickOwnBehaviorHostileDominant() {
        adaptiveUI.tapWithAction()
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostileDominant.key())
    }
    //************************
    
    // ******** click other behavior BUTTONS
    @IBAction func clickOtherBehaviorOpen() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.open.key())
    }
    @IBAction func clickOtherBehaviorFriendlyDominant() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendyDominant.key())
    }
    @IBAction func clickOtherBehaviorFriendly() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendly.key())
    }
    @IBAction func clickOtherBehaviorFriendlyObsequious() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendlyObsequious.key())
    }
    @IBAction func clickOtherBehaviorClose() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.close.key())
    }
    @IBAction func clickOtherBehaviorHostileObsequious() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostileObsequios.key())
    }
    @IBAction func clickOtherBehaviorHostile() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostile.key())
    }
    @IBAction func clickOtherBehaviorHostileDominant() {
        adaptiveUI.tapWithAction()
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostileDominant.key())
    }
    //************************
    
    // ******** click did Sport BUTTONS
    @IBAction func clickDidSportYes() {
        adaptiveUI.tapWithAction()
        self.trackDidSport(didSport: true)
    }
    @IBAction func clickDidSportNo() {
        adaptiveUI.tapWithAction()
        self.trackDidSport(didSport: false)
    }
    //************************
    
    

    // ******** TRACK Funcions
    private func startTrack(){
        trackHelper = TrackHelper()
        
        
        //Hide ALl Screen
        groupFeeling.setAlpha(0)
        groupFeeling.setHeight(0)
        groupOwnBehavior.setAlpha(0)
        groupOwnBehavior.setHeight(0)
        groupOtherBehavior.setAlpha(0)
        groupOtherBehavior.setHeight(0)
        groupSport.setAlpha(0)
        groupSport.setHeight(0)
        
        //Set Neural State Adaptiv UI
        adaptiveUI.startTrack()
        
        //measure Puls
        self.starWorkout()
        
        self.startTrackContext()
    }
    
    private func startTrackContext(){
        self.setTitle("What are you doing?")
    }
    
    private func trackContext(context:String){
        trackHelper!.setContext(context: context)
        self.btnBackFeeling.setTitle("<  " + context.uppercased())
        switchGroup(hideGroup: groupContext, showGroup: groupFeeling)
        
        self.startTrackFeeling()
    }
    
    private func startTrackFeeling(){
        self.setTitle("How do you feel?")
    }
    
    private func trackFeeling(feeling:String){
        trackHelper!.setFeeling(feeling: feeling)
        self.btnBackOwnBehavior.setTitle("<  " + feeling.uppercased())
        switchGroup(hideGroup: groupFeeling, showGroup: groupOwnBehavior)
        
        
        self.startTrackOwnBehavior()
    }
    
    private func startTrackOwnBehavior(){
        self.setTitle("own behavior:")
    }
    
    private func trackOwnBehavior(ownBehavior: String){
        trackHelper!.setOwnBehavior(ownBehavior: ownBehavior)
        self.btnBackOtherBehavior.setTitle("<  " + ownBehavior.uppercased())
        switchGroup(hideGroup: groupOwnBehavior, showGroup: groupOtherBehavior)
        
        self.startTrackOtherBehavior()
    }
    
    private func startTrackOtherBehavior(){
        self.setTitle("other bahavior:")
    }
    
    private func trackOtherBehavior(otherBehavior: String){
        trackHelper!.setOtherBehavior(otherBehavior: otherBehavior)
        self.btnBackDidSport.setTitle("<  " + otherBehavior.uppercased())
        switchGroup(hideGroup: groupOtherBehavior, showGroup: groupSport)
        
        self.startTrackDidSport()
    }
    
    private func startTrackDidSport(){
        self.setTitle("Did you do sport?")
    }
    private func trackDidSport(didSport: Bool){
        trackHelper!.setDidSport(didSport: didSport)
        
        self.endTrack()
    }
    private func endTrack(){
        //STOP MEASURE PULS
        stopWorkout()
        
        //GET STEPS
        self.retrieveStepCount { (steps) in
            self.trackHelper.setStepCount(stepCount: steps)
            
            //STORE DATA LOCAL
            self.trackHelper.storeUserTrackData()
            NotificationCenter.default.post(name: NSNotification.Name(Constants.WatchNotification.dataAdded.key()), object: nil)
            
            //SEND DATA
            if WCSession.isSupported()  {
                WCSession.default().transferUserInfo(self.trackHelper.getTrackDataSend())
            }
            //Close
            self.dismiss()
        }
    }
    //************************
    
    // ******** Functions for Measure Puls und Steps
    private func starWorkout(){
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .crossTraining
        configuration.locationType = .indoor
        
        
        do{
            self.workoutSession = try HKWorkoutSession.init(configuration: configuration)
        } catch{
            print(error)
        }
        self.workoutSession?.delegate = self
        self.healthStore.start(self.workoutSession!)
    }
    
    private func stopWorkout(){
        if let workout = self.workoutSession{
            self.healthStore.end(workout)
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            workoutDidStart(date)
        case .ended:
            workoutDidEnd(date)
        default:
            print("Unexpected state \(toState)")
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        // Do nothing for now
        print("Workout error")
    }
    
    
    private func workoutDidStart(_ date : Date) {
        if let query = createHeartRateStreamingQuery(date) {
            self.currenQuery = query
            healthStore.execute(query)
        } else {
            print("can not start Query for HeartRate")
        }
    }
    
    private func workoutDidEnd(_ date : Date) {
        healthStore.stop(self.currenQuery!)
    }
    
    private func createHeartRateStreamingQuery(_ workoutStartDate: Date) -> HKQuery? {
        
        
        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else { return nil }
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictEndDate )
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate])
        
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            self.updateHeartRate(sampleObjects)
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            //self.anchor = newAnchor!
            self.updateHeartRate(samples)
        }
        return heartRateQuery
    }
    
    private func updateHeartRate(_ samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {return}
        
        DispatchQueue.main.async {
            guard let sample = heartRateSamples.first else{return}
            let value = Int(sample.quantity.doubleValue(for: self.heartRateUnit))
            
            //Send Heartrate to Track Helper --> for min and max Puls
            self.trackHelper!.newPulsData(pulsData: value)
            
            //Send Heartreate to Adaptive UI Handler --> for changing UI depends on Heartrate
            self.adaptiveUI.newHeartRate(puls: value)
        }
    }
    
    private func retrieveStepCount(completion: @escaping (_ stepRetrieved: Int) -> Void) {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //   Get the start of the day
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = cal.startOfDay(for: now)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate as Date, intervalComponents:interval)
        
        //INIT HANDLE QUERY
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                //  Something went Wrong
                completion(0)
                return
            }
            
            if let myResults = results{ myResults.enumerateStatistics(from: startDate, to: now, with: { statistics, stop in
                    if let quantity = statistics.sumQuantity() {
                        let steps = Int(quantity.doubleValue(for: HKUnit.count()))
                        //print("Steps = \(steps)")
                        completion(steps)
                        
                    }else{
                        completion(0)
                    }
                })
            }else{
                completion(0)
            }
        }
        //Excute Query
        if(HKHealthStore.isHealthDataAvailable()){
            healthStore.execute(query)
        }else{
            completion(0)
            return
        }
        
        //Auf WatchOS in simulator wird query nicht ausgeführt
        #if (arch(i386) || arch(x86_64)) && os(watchOS)
            completion(0)
            return
        #endif
    }
    
    // ******** GENERAL UI Funcions
    private func switchGroup(hideGroup: WKInterfaceGroup, showGroup: WKInterfaceGroup){
        
        self.animate(withDuration: 0.5) {
            hideGroup.setAlpha(0)
        }
        
        self.animate(withDuration: 0.5) {
            hideGroup.setHeight(0)
        }
        
        DispatchQueue.init(label: "TEST").asyncAfter(wallDeadline: .now() + .milliseconds(500)) {
            self.animate(withDuration: 0.5) {
                showGroup.setAlpha(1)
            }
            self.animate(withDuration: 0.5) {
                showGroup.sizeToFitHeight()
            }
        }
    }
    
    private func addGroupsToAdaptiveUI(){
        adaptiveUI.addGroupIcon(group: groupContextIcons)
        adaptiveUI.addGroupIcon(group: groupFeelingIcons)
        adaptiveUI.addGroupIcon(group: groupOwnBehaviorIcons)
        adaptiveUI.addGroupIcon(group: groupOtherBehaviorIcons)
        
        adaptiveUI.addGroupList(group: groupContextList)
        adaptiveUI.addGroupList(group: groupFeelingList)
        adaptiveUI.addGroupList(group: groupOwnBehaviorList)
        adaptiveUI.addGroupList(group: groupOtherBehaviorList)
    }
    
    private func removeGroupsToAdaptiveUI(){
        adaptiveUI.removeGroupIcon(group: groupContextIcons)
        adaptiveUI.removeGroupIcon(group: groupFeelingIcons)
        adaptiveUI.removeGroupIcon(group: groupOwnBehaviorIcons)
        adaptiveUI.removeGroupIcon(group: groupOtherBehaviorIcons)
        
        adaptiveUI.removeGroupList(group: groupContextList)
        adaptiveUI.removeGroupList(group: groupFeelingList)
        adaptiveUI.removeGroupList(group: groupOwnBehaviorList)
        adaptiveUI.removeGroupList(group: groupOtherBehaviorList)
    }
    
    private func addIconButtonsToAdaptiveUI(){
        adaptiveUI.addIconButton(button: groupBtnWork)
        adaptiveUI.addIconButton(button: groupBtnHome)
        adaptiveUI.addIconButton(button: groupBtnDoctor)
        adaptiveUI.addIconButton(button: groupBtnSport)
        adaptiveUI.addIconButton(button: groupBtnReleax)
        adaptiveUI.addIconButton(button: groupBtnMusic)
        adaptiveUI.addIconButton(button: groupBtnTv)
        adaptiveUI.addIconButton(button: groupBtnGame)
        adaptiveUI.addIconButton(button: groupBtnRead)
        adaptiveUI.addIconButton(button: groupBtnFamily)
        adaptiveUI.addIconButton(button: groupBtnFriends)
        adaptiveUI.addIconButton(button: groupBtnShopping)
        
        adaptiveUI.addIconButton(button: goupBtnVeryHappy)
        adaptiveUI.addIconButton(button: goupBtnHappy)
        adaptiveUI.addIconButton(button: goupBtnSmilling)
        adaptiveUI.addIconButton(button: goupBtnConfused)
        adaptiveUI.addIconButton(button: goupBtnSad)
        adaptiveUI.addIconButton(button: goupBtnUnhappy)
        adaptiveUI.addIconButton(button: goupBtnMad)
        
        adaptiveUI.addIconButton(button: goupBtnOwnOpen)
        adaptiveUI.addIconButton(button: goupBtnOwnHostileDominat)
        adaptiveUI.addIconButton(button: goupBtnOwnFriendlyDominant)
        adaptiveUI.addIconButton(button: goupBtnOwnHostile)
        adaptiveUI.addIconButton(button: goupBtnFriendly)
        adaptiveUI.addIconButton(button: groupBtnOwnHostileObsequious)
        adaptiveUI.addIconButton(button: groupBtnOwnFriendlyObsequious)
        adaptiveUI.addIconButton(button: groupBtnOwnClose)
        
        adaptiveUI.addIconButton(button: goupBtnOtherOpen)
        adaptiveUI.addIconButton(button: goupBtnOtherHostileDominat)
        adaptiveUI.addIconButton(button: goupBtnOtherFriendlyDominant)
        adaptiveUI.addIconButton(button: goupBtnOtherHostile)
        adaptiveUI.addIconButton(button: goupBtnOtherFriendly)
        adaptiveUI.addIconButton(button: groupBtnOtherHostileObsequious)
        adaptiveUI.addIconButton(button: groupBtnOtherFriendlyObsequious)
        adaptiveUI.addIconButton(button: groupBtnOtherClose)
    }
    
    private func removeIconButtonsToAdaptiveUI(){
        adaptiveUI.removeIconButton(button: groupBtnWork)
        adaptiveUI.removeIconButton(button: groupBtnHome)
        adaptiveUI.removeIconButton(button: groupBtnDoctor)
        adaptiveUI.removeIconButton(button: groupBtnSport)
        adaptiveUI.removeIconButton(button: groupBtnReleax)
        adaptiveUI.removeIconButton(button: groupBtnMusic)
        adaptiveUI.removeIconButton(button: groupBtnTv)
        adaptiveUI.removeIconButton(button: groupBtnGame)
        adaptiveUI.removeIconButton(button: groupBtnRead)
        adaptiveUI.removeIconButton(button: groupBtnFamily)
        adaptiveUI.removeIconButton(button: groupBtnFriends)
        adaptiveUI.removeIconButton(button: groupBtnShopping)
        
        adaptiveUI.removeIconButton(button: goupBtnVeryHappy)
        adaptiveUI.removeIconButton(button: goupBtnHappy)
        adaptiveUI.removeIconButton(button: goupBtnSmilling)
        adaptiveUI.removeIconButton(button: goupBtnConfused)
        adaptiveUI.removeIconButton(button: goupBtnSad)
        adaptiveUI.removeIconButton(button: goupBtnUnhappy)
        adaptiveUI.removeIconButton(button: goupBtnMad)
        
        adaptiveUI.removeIconButton(button: goupBtnOwnOpen)
        adaptiveUI.removeIconButton(button: goupBtnOwnHostileDominat)
        adaptiveUI.removeIconButton(button: goupBtnOwnFriendlyDominant)
        adaptiveUI.removeIconButton(button: goupBtnOwnHostile)
        adaptiveUI.removeIconButton(button: goupBtnFriendly)
        adaptiveUI.removeIconButton(button: groupBtnOwnHostileObsequious)
        adaptiveUI.removeIconButton(button: groupBtnOwnFriendlyObsequious)
        adaptiveUI.removeIconButton(button: groupBtnOwnClose)
        
        adaptiveUI.removeIconButton(button: goupBtnOtherOpen)
        adaptiveUI.removeIconButton(button: goupBtnOtherHostileDominat)
        adaptiveUI.removeIconButton(button: goupBtnOtherFriendlyDominant)
        adaptiveUI.removeIconButton(button: goupBtnOtherHostile)
        adaptiveUI.removeIconButton(button: goupBtnOtherFriendly)
        adaptiveUI.removeIconButton(button: groupBtnOtherHostileObsequious)
        adaptiveUI.removeIconButton(button: groupBtnOtherFriendlyObsequious)
        adaptiveUI.removeIconButton(button: groupBtnOtherClose)
    }
    //************************
    
    deinit {
        self.removeIconButtonsToAdaptiveUI()
        self.removeGroupsToAdaptiveUI()
    }
}
