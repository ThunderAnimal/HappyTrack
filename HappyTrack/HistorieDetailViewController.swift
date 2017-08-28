//
//  HistorieDetailController.swift
//  HappyTrack
//
//  Created by Martin Weber on 28.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit



class HistorieDetailViewController: UIViewController {
    
    var trackData: TrackDataEntity?
    
    @IBOutlet weak var imgState: UIImageView!
    
    @IBOutlet weak var labelContext: UILabel!
    @IBOutlet weak var labelOwnBehavior: UILabel!
    @IBOutlet weak var labelOtherBehavior: UILabel!
    @IBOutlet weak var labelDidSport: UILabel!
    @IBOutlet weak var labelMinPuls: UILabel!
    @IBOutlet weak var labelMaxPuls: UILabel!
    @IBOutlet weak var labelCountSteps: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.setTitle(title: "Detail", subtitle: (trackData?.date)! + " " + (trackData?.time)!)
        self.updateUI()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setDetailData (trackData: TrackDataEntity){
        self.trackData = trackData
    }
    
    private func updateUI(){
        
        if(trackData !== nil){
            switch trackData!.feeling {
            case Constants.TrackFeeling.veryHappy.key(): imgState.image = UIImage(named: "very_happy")
            case Constants.TrackFeeling.happy.key(): imgState.image = UIImage(named: "happy")
            case Constants.TrackFeeling.smiling.key(): imgState.image = UIImage(named: "smiling")
            case Constants.TrackFeeling.confused.key(): imgState.image = UIImage(named: "confused")
            case Constants.TrackFeeling.sad.key(): imgState.image = UIImage(named: "sad")
            case Constants.TrackFeeling.unhappy.key(): imgState.image = UIImage(named: "unhappy")
            case Constants.TrackFeeling.anger.key(): imgState.image = UIImage(named: "mad")
            default: imgState.image = UIImage(named: "smiling")
            }
        }
        
        self.labelContext.text = trackData!.context
        self.labelOwnBehavior.text = trackData!.ownBehavior
        self.labelOtherBehavior.text = trackData!.otherBehavior
        self.labelMinPuls.text = String(trackData!.minPuls)
        self.labelMaxPuls.text = String(trackData!.maxPuls)
        self.labelCountSteps.text = String(trackData!.stepCount)
        
        if(trackData!.didSport){
            self.labelDidSport.text = "YES"
        }else{
            self.labelDidSport.text = "NO"
        }
        
        
    }
}
