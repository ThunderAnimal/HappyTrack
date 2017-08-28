//
//  HappyTrackViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 10.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift
class HappyTrackViewController: UIViewController {
    
    @IBOutlet weak var imgState: UIImageView!
    @IBOutlet weak var inputLastTrackTime: UILabel!
    @IBOutlet weak var inputLastTrackDate: UILabel!
    
    var realmNotifiction: RLMNotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let realm = try! Realm()
        realmNotifiction = realm.addNotificationBlock({ note, realm in
            self.updateUI()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func updateUI(){
    
        if let lastData = AppComponent.instance.getTrackDataController().getLastTrackData(){
            switch lastData.feeling {
                case Constants.TrackFeeling.veryHappy.key(): imgState.image = UIImage(named: "very_happy")
                case Constants.TrackFeeling.happy.key(): imgState.image = UIImage(named: "happy")
                case Constants.TrackFeeling.smiling.key(): imgState.image = UIImage(named: "smiling")
                case Constants.TrackFeeling.confused.key(): imgState.image = UIImage(named: "confused")
                case Constants.TrackFeeling.sad.key(): imgState.image = UIImage(named: "sad")
                case Constants.TrackFeeling.unhappy.key(): imgState.image = UIImage(named: "unhappy")
                case Constants.TrackFeeling.anger.key(): imgState.image = UIImage(named: "mad")
                default: imgState.image = UIImage(named: "smiling")
            }
            
            self.inputLastTrackTime.text = lastData.time
            self.inputLastTrackDate.text = lastData.date
        }else{
            self.inputLastTrackTime.text = "NO TRACK DATA"
            self.inputLastTrackDate.text = ""
        }

    }
    
    deinit {
        realmNotifiction?.stop()
    }

}
