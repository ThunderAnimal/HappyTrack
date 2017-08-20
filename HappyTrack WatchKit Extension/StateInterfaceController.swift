//
//  StateInterfaceController.swift
//  HappyTrack
//
//  Created by Martin Weber on 20.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit

class StateInterfaceController: WKInterfaceController{
    
    @IBOutlet var imgState: WKInterfaceImage!
    @IBOutlet var labelLastTrackTime: WKInterfaceLabel!
    @IBOutlet var labelLastTrackDate: WKInterfaceLabel!
    
    lazy var notificationCenter: NotificationCenter = {
        return NotificationCenter.default
    }()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateGUI()
        self.setupNotificationCenter()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        notificationCenter.removeObserver(self)
    }
    
    private func setupNotificationCenter(){
        notificationCenter.addObserver(forName: NSNotification.Name(Constants.WatchNotification.dataAdded.key()), object: nil, queue: nil) { _ in
            self.updateGUI()
        }
    }
    
    private func updateGUI(){
        let userDefault = UserDefaults()
        if let feeling = userDefault.string(forKey: Constants.TrackValues.feeling.key()){
            switch feeling {
            case Constants.TrackFeeling.veryHappy.key(): imgState.setImageNamed("very_happy")
                case Constants.TrackFeeling.happy.key(): imgState.setImageNamed("happy")
                case Constants.TrackFeeling.smiling.key(): imgState.setImageNamed("smiling")
                case Constants.TrackFeeling.confused.key(): imgState.setImageNamed("confused")
                case Constants.TrackFeeling.sad.key(): imgState.setImageNamed("sad")
                case Constants.TrackFeeling.unhappy.key(): imgState.setImageNamed("unhappy")
                case Constants.TrackFeeling.anger.key(): imgState.setImageNamed("mad")
                default: imgState.setImageNamed("smiling")
            }
        }
        if let date = userDefault.object(forKey: Constants.TrackValues.date.key()) as? Date{
            let calendar = Calendar.current
            
            let dateFormatDay = DateFormatter()
            dateFormatDay.dateFormat = "dd.MM.yyyy"
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            labelLastTrackTime.setText(String(hour) + ":" + String(minutes))
            labelLastTrackDate.setText(dateFormatDay.string(from: date))
        }else{
            labelLastTrackTime.setText("NO TRACK DATA")
            labelLastTrackDate.setText("")
        }
    }
    
}
