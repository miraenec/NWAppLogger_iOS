//
//  CalendarUtil.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2018년 nextweb. All rights reserved.
//

import Foundation

@objc
class CalendarUtil: NSObject {
    static func currentMilliSecond() -> NSNumber {
        let currentTime = Int64(Date().timeIntervalSince1970 * 1000)
        return NSNumber(value: currentTime as Int64)
    }
    
    static func currentTime(_ timeMiliSecond:TimeInterval) -> String {
        
        /**
         let timeAsInt: Int = 1434003904260
         let timeAsInterval: NSTimeInterval = Double(timeAsInt)/1000
         let theDate = NSDate(timeIntervalSince1970: timeAsInterval)
        */
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_kr")
        format.timeZone = TimeZone(identifier: "KST")
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let theDate = Date(timeIntervalSinceReferenceDate: timeMiliSecond)
        let today = format.string(from: theDate)
        
        return today as String
    }
    
    static func currentTime() -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_kr")
        format.timeZone = TimeZone(identifier: "KST")
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let today = format.string(from: Date())
        
        return today as String
    }
}
