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
    public func addTrackData(trackData:TrackDataEntity){
        let realm = try! Realm()
        try! realm.write{
            realm.add(trackData)
        }
    }
    
    public func getLastTrackData() -> TrackDataEntity?{
        let realm = try! Realm()
        if let res = realm.objects(TrackDataEntity.self).last{
            return res
        }else{
            return nil
        }
    }
}
