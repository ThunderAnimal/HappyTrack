//
//  OnBoardNameViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 17.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class OnboardNameViewController: OnboardViewController {
    @IBOutlet weak var nameBorder: UIView!
    @IBOutlet weak var lastnameBorder: UIView!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputLastname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func updateUI(){
        let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key())
    
        inputName.text = shareDefaults?.string(forKey: Constants.Person.name.key())
        inputLastname.text = shareDefaults?.string(forKey: Constants.Person.last_name.key())
    }
    
    @IBAction func startEditName(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5) { 
            self.nameBorder.backgroundColor = AppColor().primaryColor
        }
        
        
    }
    @IBAction func entEdirName(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.nameBorder.backgroundColor = UIColor.lightGray
        }
        
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            shareDefaults.set(inputName.text, forKey: Constants.Person.name.key())
        }
    }
    
    @IBAction func startEditLastname(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.lastnameBorder.backgroundColor = AppColor().primaryColor        }
        
    }
    @IBAction func endEditLastname(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.lastnameBorder.backgroundColor = UIColor.lightGray
        }
        
        if let shareDefaults = UserDefaults(suiteName: Constants.AppGroups.person_name.key()){
            shareDefaults.set(inputLastname.text, forKey: Constants.Person.last_name.key())
        }
        
    }
    
    @IBAction func clickNext(_ sender: UIButton) {
        self.dismissKeyboard()
    }
}
