//
//  ObjectPara.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import Foundation

struct ObjectPara {
    
    var name: String?
    var key: String
    var minimumValue: Float?
    var maximumValue: Float?
    var currentValue: Float
    
    init(_ key: String,_ value: Float) {
        
        self.key = key
        self.currentValue = value
        
    }
    
    init(_ name: String,_ key: String,_ minimumValue: Float,_ maximumValue: Float,_ currentValue: Float) {
        
        self.name = name
        self.key = key
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.currentValue = currentValue
        
    }
    
}
