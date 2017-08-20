//
//  TrackDataHandler.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import RealmSwift

class TrackDataHandler{
    private let converter: TrackDataConverter
    
    init(){
        converter = TrackDataConverter()
    }
    
    public func addTrackData(trackData:TrackData){
        let realm = try! Realm()
        try! realm.write{
            realm.add(converter.to(value: trackData))
        }
    }
    
    public func getLastTrackData() -> TrackData?{
        let realm = try! Realm()
        if let res = realm.objects(TrackDataEntity.self).last{
            return converter.from(value: res)
        }else{
            return nil
        }
    }
}
