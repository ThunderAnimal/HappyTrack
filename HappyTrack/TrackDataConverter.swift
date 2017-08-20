//
//  TrackDataConverter.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

class TrackDataConverter{
    public func  from(value: TrackDataEntity) -> TrackData{
        return TrackData(context: value.context, feeling: value.feeling, ownBehavior: value.ownBehavior, otherBehavior: value.otherBehavior, didSport: value.didSport, minPuls: value.minPuls, maxPuls: value.maxPuls, stepCount: value.stepCount)
    }
    
    public func to(value: TrackData) -> TrackDataEntity{
        let entity = TrackDataEntity()
        entity.date = value.date
        entity.context = value.context
        entity.feeling = value.feeling
        entity.ownBehavior = value.ownBehavior
        entity.otherBehavior = value.otherBehavior
        entity.didSport = value.didSport
        entity.minPuls = value.minPuls
        entity.maxPuls = value.maxPuls
        entity.stepCount = value.stepCount
        
        return entity
    }
}
