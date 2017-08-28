//
//  TrackData.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

class TrackData{
    public let date :Date
    
    public let context :String
    public let feeling: String
    public let ownBehavior: String
    public let otherBehavior: String
    
    public let didSport: Bool
    public let minPuls: Int
    public let maxPuls: Int
    public let stepCount: Int
    
    required init(context:String,
                  feeling:String,
                  ownBehavior:String,
                  otherBehavior: String,
                  didSport: Bool,
                  minPuls: Int,
                  maxPuls: Int,
                  stepCount: Int) {
        self.date = Date()
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
