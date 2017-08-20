//
//  TrackDataEntity.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import RealmSwift

class TrackDataEntity: Object {
    dynamic var date = Date()
    dynamic var context = ""
    dynamic var feeling = ""
    dynamic var ownBehavior = ""
    dynamic var otherBehavior = ""
    dynamic var didSport = false
    dynamic var minPuls = 0
    dynamic var maxPuls = 0
    dynamic var stepCount = 0
}
