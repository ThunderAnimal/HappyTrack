//
//  convCGValues.swift
//  HappyTrack
//
//  Created by Martin Weber on 02.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat){
        self.init(x:x,y:y,width:width,height:height)
    }
}

extension CGSize{
    init(_ width:CGFloat, _ height:CGFloat){
        self.init(width:width, height: height)
    }
}

extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat){
        self.init(x:x,y:y)
    }
}
