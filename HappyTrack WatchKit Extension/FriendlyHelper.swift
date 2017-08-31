//
//  FriendlyHelper.swift
//  HappyTrack
//
//  Created by Martin Weber on 19.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation

class FriendlyHelper {
    private let greetings = [
        "What's up?",
        "Whaddup",
        "Greetings and salutations!",
        "Howdy howdy howdy!",
        "Yo!",
        "What’s crackin’?",
        "Hey sunshine"
    ]
    private let motivates = [
        "You're awesome!",
        "What a nice day, or?",
        "Success is a desicion.",
        "You are brillant!",
        "You are great.",
        "You ca do this!",
        "I believe in you."
    ]
    
    func getRandomGreetings()->String{
        let randomNum:Int = Int(arc4random_uniform(UInt32(self.greetings.count))) // range is 0 to length array greetings-1
        return greetings[randomNum]
        
    }
    func getRandomMotivates()-> String{
        let randomNum:Int = Int(arc4random_uniform(UInt32(self.motivates.count))) // range is 0 to length array motivates-1
        return motivates[randomNum]
    }
}
