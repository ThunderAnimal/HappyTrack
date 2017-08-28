//
//  TrackDataEntity.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class TrackDataEntity: Object {
    dynamic var realDate = Date()
    dynamic var date = ""
    dynamic var time = ""
    dynamic var context = ""
    dynamic var feeling = ""
    dynamic var ownBehavior = ""
    dynamic var otherBehavior = ""
    dynamic var didSport = false
    dynamic var minPuls = 0
    dynamic var maxPuls = 0
    dynamic var stepCount = 0
    
    convenience init(realDate: Date,date:String, time:String, context:String, feeling: String, ownBehavior:String, otherBehavior:String, didSport: Bool, minPuls:Int, maxPuls:Int, stepCount:Int) {
        self.init()
        self.realDate = realDate
        self.date = date
        self.time = time
        self.context = context
        self.feeling = feeling
        self.ownBehavior = ownBehavior
        self.otherBehavior = otherBehavior
        self.didSport = didSport
        self.minPuls = minPuls
        self.maxPuls = maxPuls
        self.stepCount = stepCount
    }
    
    
}
