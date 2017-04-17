//
//  Calculations.swift
//  NutriCalc
//
//  Created by B0nty on 16/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import Foundation

class Calculations: Costumer {
    
    
    func bmrWomen(height: Double, weight: Double, age: Double) -> Double {
        return ((66.47 + (13.75 * weight) + (5.03 * height) - (6.75 * age)) / 100)
    }
    
    
    func bmrMen(height: Double, weight: Double, age: Double) -> Double {
        return ((655.10 + (9.56 * weight) + (1.85 * height) - (4.68 * age)) / 100)
        
    }
    
    
}
