//
//  TrackInterfaceControllerMotivater.swift
//  HappyTrack
//
//  Created by Martin Weber on 04.09.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit

class TrackInterfaceMotivater: WKInterfaceController {
 
    @IBAction func closeModal() {
        self.dismiss()
        AdaptivUI.shared.closeModalOnTrack()
    }
}
