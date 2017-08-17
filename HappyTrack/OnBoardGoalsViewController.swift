//
//  OnBoardGoalsViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 17.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class OnboardGoalsViewController: OnboardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickReady(_ sender: UIButton) {
        self.finishOnBaording()
    }
}
