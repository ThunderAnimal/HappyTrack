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


class TrackInterfaceController: WKInterfaceController {
    
    @IBOutlet var groupContext: WKInterfaceGroup!
    @IBOutlet var groupFeeling: WKInterfaceGroup!
    @IBOutlet var groupOwnBehavior: WKInterfaceGroup!
    @IBOutlet var groupOtherBehavior: WKInterfaceGroup!
    @IBOutlet var groupSport: WKInterfaceGroup!

    @IBOutlet var btnBackFeeling: WKInterfaceButton!
    @IBOutlet var btnBackOwnBehavior: WKInterfaceButton!
    @IBOutlet var btnBackOtherBehavior: WKInterfaceButton!
    @IBOutlet var btnBackDidSport: WKInterfaceButton!
    
    private var trackHelper: TrackHelper!
    
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        // Configure interface objects here.
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
    
    @IBAction func clickBackFeeling() {
        self.switchGroup(hideGroup: groupFeeling, showGroup: groupContext)
    }
    @IBAction func clickBackOwnBehavior() {
        self.switchGroup(hideGroup: groupOwnBehavior, showGroup: groupFeeling)
    }
    @IBAction func clickBackOtherBehavior() {
        self.switchGroup(hideGroup: groupOtherBehavior, showGroup: groupOwnBehavior)
    }
    @IBAction func clickBackDidSport() {
        self.switchGroup(hideGroup: groupSport, showGroup: groupOtherBehavior)
    }
    
    @IBAction func clickContextWork() {
        self.trackContext(context: Constants.TrackContext.work.key())
    }
    @IBAction func clickContextHome() {
        self.trackContext(context: Constants.TrackContext.home.key())
    }
    @IBAction func clickContexDoctor() {
        self.trackContext(context: Constants.TrackContext.doctor.key())
    }
    @IBAction func clickContextSport() {
        self.trackContext(context: Constants.TrackContext.sport.key())
    }
    @IBAction func clickContextReleax() {
        self.trackContext(context: Constants.TrackContext.relax.key())
    }
    @IBAction func clickContextMusic() {
        self.trackContext(context: Constants.TrackContext.music.key())
    }
    @IBAction func clickContextTv() {
        self.trackContext(context: Constants.TrackContext.television.key())
    }
    @IBAction func clickContextGame() {
        self.trackContext(context: Constants.TrackContext.game.key())
    }
    @IBAction func clickContextRead() {
        self.trackContext(context: Constants.TrackContext.read.key())
    }
    @IBAction func clickContextFamilie() {
        self.trackContext(context: Constants.TrackContext.family.key())
    }
    @IBAction func clickContextFriends() {
        self.trackContext(context: Constants.TrackContext.friends.key())
    }
    @IBAction func clickContexShopping() {
        self.trackContext(context: Constants.TrackContext.shopping.key())
    }
    @IBAction func clickContextOther() {
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

    @IBAction func clickFeelingVeryHappy() {
        self.trackFeeling(feeling: Constants.TrackFeeling.veryHappy.key())
    }
    @IBAction func clickFeelingHappy() {
        self.trackFeeling(feeling: Constants.TrackFeeling.happy.key())
    }
    @IBAction func clickFeelingSmiling() {
        self.trackFeeling(feeling: Constants.TrackFeeling.smiling.key())
    }
    @IBAction func clickFeelingConfused() {
        self.trackFeeling(feeling: Constants.TrackFeeling.confused.key())
    }
    @IBAction func clickFeelingSad() {
        self.trackFeeling(feeling: Constants.TrackFeeling.sad.key())
    }
    @IBAction func clickFeelingUnHappy() {
        self.trackFeeling(feeling: Constants.TrackFeeling.unhappy.key())
    }
    @IBAction func clickFeelingAnger() {
        self.trackFeeling(feeling: Constants.TrackFeeling.anger.key())
    }
    
    @IBAction func clickOwnBehaviorOpen() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.open.key())
    }
    @IBAction func clickOwnBehaviorFriendlyDominant() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendyDominant.key())
    }
    @IBAction func clickOwnBehaviorFriendly() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendly.key())
    }
    @IBAction func clickOwnBehaviorFriendlyObsequious() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.friendlyObsequious.key())
    }
    @IBAction func clickOwnBehaviorClose() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.close.key())
    }
    @IBAction func clickOwnBehaviorHostileObsequious() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostileObsequios.key())
    }
    @IBAction func clickOwnBehaviorHostile() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostile.key())
    }
    @IBAction func clickOwnBehaviorHostileDominant() {
        self.trackOwnBehavior(ownBehavior: Constants.TrackBehavior.hostileDominant.key())
    }
    
    @IBAction func clickOtherBehaviorOpen() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.open.key())
    }
    @IBAction func clickOtherBehaviorFriendlyDominant() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendyDominant.key())
    }
    @IBAction func clickOtherBehaviorFriendly() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendly.key())
    }
    @IBAction func clickOtherBehaviorFriendlyObsequious() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.friendlyObsequious.key())
    }
    @IBAction func clickOtherBehaviorClose() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.close.key())
    }
    @IBAction func clickOtherBehaviorHostileObsequious() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostileObsequios.key())
    }
    @IBAction func clickOtherBehaviorHostile() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostile.key())
    }
    @IBAction func clickOtherBehaviorHostileDominant() {
        self.trackOtherBehavior(otherBehavior: Constants.TrackBehavior.hostileDominant.key())
    }
    
    @IBAction func clickDidSportYes() {
        self.trackDidSport(didSport: true)
    }
    @IBAction func clickDidSportNo() {
        self.trackDidSport(didSport: false)
    }
    
    

    
    private func startTrack(){
        trackHelper = TrackHelper()
        
        //TODO measure Puls
        
        groupFeeling.setAlpha(0)
        groupFeeling.setHeight(0)
        groupOwnBehavior.setAlpha(0)
        groupOwnBehavior.setHeight(0)
        groupOtherBehavior.setAlpha(0)
        groupOtherBehavior.setHeight(0)
        groupSport.setAlpha(0)
        groupSport.setHeight(0)
        
    }
    
    private func trackContext(context:String){
        trackHelper!.setContext(context: context)
        self.btnBackFeeling.setTitle("<  " + context.uppercased())
        switchGroup(hideGroup: groupContext, showGroup: groupFeeling)
    }
    private func trackFeeling(feeling:String){
        trackHelper!.setFeeling(feeling: feeling)
        self.btnBackOwnBehavior.setTitle("<  " + feeling.uppercased())
        switchGroup(hideGroup: groupFeeling, showGroup: groupOwnBehavior)
        
    }
    private func trackOwnBehavior(ownBehavior: String){
        trackHelper!.setOwnBehavior(ownBehavior: ownBehavior)
        self.btnBackOtherBehavior.setTitle("<  " + ownBehavior.uppercased())
        switchGroup(hideGroup: groupOwnBehavior, showGroup: groupOtherBehavior)
    }
    private func trackOtherBehavior(otherBehavior: String){
        trackHelper!.setOtherBehavior(otherBehavior: otherBehavior)
        self.btnBackDidSport.setTitle("<  " + otherBehavior.uppercased())
        switchGroup(hideGroup: groupOtherBehavior, showGroup: groupSport)
    }
    private func trackDidSport(didSport: Bool){
        trackHelper!.setDidSport(didSport: didSport)
        endTrack()
    }
    private func endTrack(){
        //STOP MEASURE PULS
        
        //GET STEPS
        
        //SET DATA
        
        //STORE DATA LOCAL
        trackHelper.storeUserTrackData()
        NotificationCenter.default.post(name: NSNotification.Name(Constants.WatchNotification.dataAdded.key()), object: nil)
        
        //SEND DATA
        if WCSession.isSupported()  {
            WCSession.default().transferUserInfo(trackHelper.getTrackDataSend())
        }
        
        //Close
        self.dismiss()
    }
    
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
}
