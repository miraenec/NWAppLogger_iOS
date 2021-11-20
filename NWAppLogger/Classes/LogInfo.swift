//
//  LogInfo.swift
//  TestLogger_Swift
//
//  Created by Hyunlang Kim on 2018. 1. 19..
//  Copyright © 2018년 NextWeb. All rights reserved.
//

import Foundation

@objc
class LogInfo: NSObject {
    
    @objc dynamic var id = 0
    @objc dynamic var ct: String = ""
    @objc dynamic var st: String = ""
    @objc dynamic var xtUid: String = ""
    @objc dynamic var xtVid: String = ""
    @objc dynamic var xtDid: String = ""
    @objc dynamic var packageName: String = ""
    @objc dynamic var appName: String = ""
    @objc dynamic var activityName: String = ""
    @objc dynamic var _className: String = ""
    @objc dynamic var evtType: String = ""
    @objc dynamic var evtDesc: String = ""
    @objc dynamic var resolution: String = ""
    @objc dynamic var appRunCount: String = ""
    @objc dynamic var macAddress: String = ""
    @objc dynamic var osType: String = ""
    @objc dynamic var osVersion: String = ""
    
    @objc dynamic var buildType: String = ""
    @objc dynamic var buildManufacturer: String = ""
    @objc dynamic var buildVersionCodename: String = ""
    @objc dynamic var buildDevice: String = ""
    @objc dynamic var buildProduct: String = ""
    @objc dynamic var buildTime: String = ""
    @objc dynamic var buildModel: String = ""
    @objc dynamic var buildVersionSdkInt: String = ""
    @objc dynamic var buildVersionRelease: String = ""
    @objc dynamic var buildBoard: String = ""
    @objc dynamic var buildHardware: String = ""
    @objc dynamic var buildUser: String = ""
    @objc dynamic var buildTags: String = ""
    @objc dynamic var buildFingerprint: String = ""
    @objc dynamic var buildBrand: String = ""
    @objc dynamic var buildDisplay: String = ""
    @objc dynamic var countryCd: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var carrier: String = ""

    
    convenience init(_ dictionary : Dictionary<String, AnyObject>) {
    
        self.init()
    
        if let ct = dictionary["ct"] { self.ct = (ct as? String)! }
        if let st = dictionary["st"] { self.st = (st as? String)! }
        if let xtUid = dictionary["xtUid"] { self.xtUid = (xtUid as? String)! }
        if let xtVid = dictionary["xtVid"] { self.xtVid = (xtVid as? String)! }
        if let xtDid = dictionary["xtDid"] { self.xtDid = (xtDid as? String)! }
        if let packageName = dictionary["packageName"] { self.packageName = (packageName as? String)! }
        if let appName = dictionary["appName"] { self.appName = (appName as? String)! }
        if let activityName = dictionary["activityName"] { self.activityName = (activityName as? String)! }
        if let _className = dictionary["className"] { self._className = (_className as? String)! }
        if let evtType = dictionary["evtType"] { self.evtType = (evtType as? String)! }
        if let evtDesc = dictionary["evtDesc"] { self.evtDesc = (evtDesc as? String)! }
        if let resolution = dictionary["resolution"] { self.resolution = (resolution as? String)! }
        if let appRunCount = dictionary["appRunCount"] { self.appRunCount = (appRunCount as? String)! }
        if let macAddress = dictionary["macAddress"] { self.macAddress = (macAddress as? String)! }
        if let osType = dictionary["osType"] { self.osType = (osType as? String)! }
        if let osVersion = dictionary["osVersion"] { self.osVersion = (osVersion as? String)! }
        if let buildType = dictionary["buildType"] { self.buildType = (buildType as? String)! }
        if let buildManufacturer = dictionary["buildManufacturer"] { self.buildManufacturer = (buildManufacturer as? String)! }
        if let buildVersionCodename = dictionary["buildVersionCodename"] { self.buildVersionCodename = (buildVersionCodename as? String)! }
        if let buildDevice = dictionary["buildDevice"] { self.buildDevice = (buildDevice as? String)! }
        if let buildProduct = dictionary["buildProduct"] { self.buildProduct = (buildProduct as? String)! }
        if let buildTime = dictionary["buildTime"] { self.buildTime = (buildTime as? String)! }
        if let buildModel = dictionary["buildModel"] { self.buildModel = (buildModel as? String)! }
        if let buildVersionSdkInt = dictionary["buildVersionSdkInt"] { self.buildVersionSdkInt = (buildVersionSdkInt as? String)! }
        if let buildVersionRelease = dictionary["buildVersionRelease"] { self.buildVersionRelease = (buildVersionRelease as? String)! }
        if let buildBoard = dictionary["buildBoard"] { self.buildBoard = (buildBoard as? String)! }
        if let buildHardware = dictionary["buildHardware"] { self.buildHardware = (buildHardware as? String)! }
        if let buildUser = dictionary["buildUser"] { self.buildUser = (buildUser as? String)! }
        if let buildTags = dictionary["buildTags"] { self.buildTags = (buildTags as? String)! }
        if let buildFingerprint = dictionary["buildFingerprint"] { self.buildFingerprint = (buildFingerprint as? String)! }
        if let buildBrand = dictionary["buildBrand"] { self.buildBrand = (buildBrand as? String)! }
        if let buildDisplay = dictionary["buildDisplay"] { self.buildDisplay = (buildDisplay as? String)! }
        if let countryCd = dictionary["countryCd"] { self.countryCd = (countryCd as? String)! }
        if let language = dictionary["language"] { self.language = (language as? String)! }
        if let carrier = dictionary["carrier"] { self.carrier = (carrier as? String)! }
    }
}

extension LogInfo {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
