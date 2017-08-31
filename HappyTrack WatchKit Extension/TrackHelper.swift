//
//  TrackHelper.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

class TrackHelper{
    private var trackdata: TrackData
    
    init() {
        trackdata = TrackData(context: "", feeling: "", ownBehavior: "", otherBehavior: "", didSport: false, minPuls: Int.max, maxPuls: Int.min, stepCount: 0)
    }
    
    public func setContext(context:String){
        trackdata = TrackData(context: context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    public func setFeeling(feeling:String){
        trackdata = TrackData(context: trackdata.context, feeling: feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    
    public func setOwnBehavior(ownBehavior:String){
                trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    public func setOtherBehavior(otherBehavior:String){
                trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    public func setDidSport(didSport:Bool){
                trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    public func newPulsData(pulsData:Int){
        if(pulsData > trackdata.maxPuls){
            setMaxPuls(maxPuls: pulsData)
        }
        if(pulsData < trackdata.minPuls){
            setMinPuls(minPuls: pulsData)
        }
    }
    private func setMinPuls(minPuls: Int){
                trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: minPuls, maxPuls: trackdata.maxPuls, stepCount: trackdata.stepCount)
    }
    private func setMaxPuls(maxPuls: Int){
             trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: maxPuls, stepCount: trackdata.stepCount)
    }
    public func setStepCount(stepCount: Int){
                trackdata = TrackData(context: trackdata.context, feeling: trackdata.feeling, ownBehavior: trackdata.ownBehavior, otherBehavior: trackdata.otherBehavior, didSport: trackdata.didSport, minPuls: trackdata.minPuls, maxPuls: trackdata.maxPuls, stepCount: stepCount)
    }
    
    public func storeUserTrackData(){
        let userDefaults = UserDefaults()
        userDefaults.set(trackdata.date, forKey: Constants.TrackValues.date.key())
        userDefaults.set(trackdata.feeling, forKey: Constants.TrackValues.feeling.key())
    }
    
    public func getTrackDataSend() -> [String: Any]{
       return [
            Constants.TrackValues.date.key(): trackdata.date,
            Constants.TrackValues.conetxt.key(): trackdata.context,
            Constants.TrackValues.feeling.key(): trackdata.feeling,
            Constants.TrackValues.ownBehavior.key(): trackdata.ownBehavior,
            Constants.TrackValues.otherBehavior.key(): trackdata.otherBehavior,
            Constants.TrackValues.didSport.key(): trackdata.didSport,
            Constants.TrackValues.minPuls.key(): trackdata.minPuls,
            Constants.TrackValues.maxPuls.key(): trackdata.maxPuls,
            Constants.TrackValues.stepCount.key(): trackdata.stepCount
        ]
    }
    
}
