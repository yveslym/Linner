//
//  Date+String.swift
//  Linner
//
//  Created by Yves Songolo on 8/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
extension Date {
    
    func timeString() -> String {
        let formatter = DateFormatter()
        let format = "HH:mm:ss"
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        
        return formatter.string(from: yourDate!)
    }
    func toString() -> String {
        let formatter = DateFormatter()
        let format =  "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        
        return formatter.string(from: yourDate!)
    }
    
}
extension String {
    func timeDate() -> Date{
        
        let formatter = DateFormatter()
        let format = "HH:mm:ss"
         formatter.dateFormat = format
        let myDate = formatter.date(from: self)
        let yourString = formatter.string(from: myDate!)
        formatter.dateFormat = format
        
        return formatter.date(from: yourString)!
    }
    func toDate()-> Date{
        
        let formatter = DateFormatter()
        let format = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = format
        let myDate = formatter.date(from: self)
        let yourString = formatter.string(from: myDate!)
        formatter.dateFormat = format
        
        return formatter.date(from: yourString)!
    }
}
