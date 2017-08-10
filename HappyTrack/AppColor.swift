//
//  AppColor.swift
//  HappyTrack
//
//  Created by Martin Weber on 01.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class AppColor {
    //google Material Color
    public let primaryColor: UIColor
    public let primaryColorDark: UIColor
    public let primaryColorLight: UIColor
    public let primaryColorBg: UIColor
    
    //google Material Color
    public let accentColor: UIColor
    public let accentColorDark: UIColor
    public let accentColotLight: UIColor
    
    //Text color
    public let textColorDark: UIColor
    public let textColorLight: UIColor
    
    init(){
        primaryColor = UIColor.init(red: 225.0/255.0, green: 152.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        primaryColorDark = UIColor.init(red: 245.0/255.0, green: 124.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        primaryColorLight = UIColor.init(red: 255.0/255.0, green: 183.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        primaryColorBg = UIColor.init(red: 255.0/255.0, green: 224.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        
        accentColor = UIColor.init(red: 0.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        accentColorDark = UIColor.init(red: 0.0/255.0, green: 145.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        accentColotLight = UIColor.init(red: 64.0/255.0, green: 196.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        textColorDark = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        textColorLight = UIColor.white
    }
    
}
