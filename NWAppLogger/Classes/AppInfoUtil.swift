//
//  AppInfoUtil.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2016년 nextweb. All rights reserved.
//

import Foundation

extension String {
    func substringWithLastInstanceOf(_ character: Character) -> String? {
        if let rangeOfIndex = rangeOfCharacter(from: CharacterSet(charactersIn: String(character)), options: .backwards) {
//            return self.substring(to: rangeOfIndex.upperBound) // Swift3
            return String(self[..<rangeOfIndex.upperBound]) // Swift4
        }
        return nil
    }
    func substringWithoutLastInstanceOf(_ character: Character) -> String? {
        if let rangeOfIndex = rangeOfCharacter(from: CharacterSet(charactersIn: String(character)), options: .backwards) {
//            return self.substring(to: rangeOfIndex.lowerBound) // Swift3
            return String(self[..<rangeOfIndex.lowerBound]) // Swift4
        }
        return nil
    }
    func lastComponent(_ character: Character) -> String? {
        let str = self.components(separatedBy: String(character))
        let count = str.count
        
        if count == 0 {
            return str[0]
        } else if count > 0 {
            return str[count-1]
        }
        
        return nil
    }
}

@objc
class AppInfoUtil: NSObject {
    
    static func appInfo(_ className:String, packageName:String) -> Dictionary<String, AnyObject> {
        var info:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        info[AppConstants.params.packageName] = packageName as AnyObject
        info[AppConstants.params.className] = className as AnyObject
        
        return info
    }
    
    static func appInfo(_ obj:AnyObject) -> Dictionary<String, AnyObject> {
        var info:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()

        info[AppConstants.params.packageName] = packageName(obj) as AnyObject
        info[AppConstants.params.className] = className(obj) as AnyObject
        
        return info
    }
    
    static func packageName(_ obj:AnyObject) -> String {
        return NSStringFromClass(type(of: obj)).substringWithoutLastInstanceOf(".") ?? ""
    }
    
    static func className(_ obj:AnyObject) -> String {
        return NSStringFromClass(type(of: obj)).lastComponent(".") ?? ""
    }
}
