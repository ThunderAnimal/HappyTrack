//
//  StartViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastnameInput: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load Data from Group Store
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            if let name = shareDefaults.string(forKey: Constants.Person.name.key()){
                nameInput.text = name
            }
            if let lastname = shareDefaults.string(forKey: Constants.Person.last_name.key()){
                lastnameInput.text = lastname
            }
        }
        
        self.sendUserNameToWatch()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func clickSaveButton(_ sender: Any) {
        self.dismissKeyboard()
        
        //SAVE Data in Group Store
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            let name = nameInput.text
            let lastname = lastnameInput.text
            
            shareDefaults.set(name, forKey: Constants.Person.name.key())
            shareDefaults.set(lastname, forKey: Constants.Person.last_name.key())
            
            shareDefaults.synchronize()
            
            self.showToast(message: "Saved Data!")
        }else {
            let alert = UIAlertController(title: "Error - Save", message: "Sorry somthing went went wrong... ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
         //Also send Data To watch
        self.sendUserNameToWatch()
    }
    
    private func sendUserNameToWatch(){
        let data = [
            Constants.Person.name.key(): nameInput.text!,
            Constants.Person.last_name.key(): lastnameInput.text!,
            Constants.PushLocalNotification.identifier.key(): "USERNAME",
            Constants.PushLocalNotification.title.key(): "Hey " + nameInput.text!,
            Constants.PushLocalNotification.body.key(): "Welcome to HappyTrack. You are AWESOME!"
        ]
        
        AppComponent.instance.getWatchConnectivityController().sendData(data: data, callback:
            {(success, errMsg) -> Void in
                if(!success){
                    print(errMsg)
                }
        })
    }
}
