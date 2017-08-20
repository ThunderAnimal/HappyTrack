//
//  StartInterfaceController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class StartInterfaceController: WKInterfaceController {
    
    @IBOutlet var usernameLabel: WKInterfaceLabel!
    
    lazy var notificationCenter: NotificationCenter = {
        return NotificationCenter.default
    }()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        
        setupNotificationCenter()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        updateGUI()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        notificationCenter.removeObserver(self)
    }
    @IBAction func clickStartTrack() {
        self.presentController(withName: "Track_Controller", context: "startTrack")
    }
    
    private func setupNotificationCenter(){
        notificationCenter.addObserver(forName: NSNotification.Name(Constants.WatchNotification.contextReceived.key()), object: nil, queue: nil, using: { _ in
                self.updateGUI()
        })
    }
    
    private func updateGUI(){
        if let name = UserDefaults.standard.string(forKey: Constants.Person.name.key()){
            usernameLabel.setText("Hey " + name + ",")
        }
    }
}

