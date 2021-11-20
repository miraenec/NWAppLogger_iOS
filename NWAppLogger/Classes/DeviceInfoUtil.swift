//
//  DeviceInfoUtil.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2018년 nextweb. All rights reserved.
//

import SwiftUI
import Foundation
import CoreTelephony
import AdSupport
import AppTrackingTransparency

@objc
class DeviceInfoUtil: NSObject {
    
    static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var TheTelephonyNetworkInfo: CTTelephonyNetworkInfo {
        struct Singleton {
            static let provider = CTTelephonyNetworkInfo()
        }
        return Singleton.provider
    }
    
    static func deviceInfo() -> Dictionary<String, AnyObject> {
        var info:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        if AppConstants.CONSOLE_LOG {
            print("\(#function) in \(type(of: self))")
            print("1. \(StringUtil.nilChecker(TheCurrentDevice.name))")
            print("2. \(StringUtil.nilChecker(TheCurrentDevice.model))")
            print("3. \(StringUtil.nilChecker(TheCurrentDevice.localizedModel))")
            print("4. \(StringUtil.nilChecker(TheCurrentDevice.systemName))")
            print("5. \(StringUtil.nilChecker(TheCurrentDevice.systemVersion))")
            print("6. \(StringUtil.nilChecker(String(TheCurrentDevice.orientation.rawValue)))")
            print("7. \(StringUtil.nilChecker((TheCurrentDevice.identifierForVendor?.uuidString)!))")
            print("8. \(StringUtil.nilChecker(IDFAString()))")
        }
        
        if AppConstants.CONSOLE_LOG {
            
            if #available(iOS 12.0, *) {
//                let carrier:[String : CTCarrier]? = TheTelephonyNetworkInfo.serviceSubscriberCellularProviders!

//                print("9. \(StringUtil.nilChecker(carrier.carrierName ?? ""))")
//                print("10. \(StringUtil.nilChecker(carrier.isoCountryCode ?? ""))")
//                print("11. \(StringUtil.nilChecker(carrier.mobileCountryCode ?? ""))")
//                print("12. \(StringUtil.nilChecker(carrier.mobileNetworkCode ?? ""))")
            }
            else {
                let carrier:CTCarrier = TheTelephonyNetworkInfo.subscriberCellularProvider!

                print("9. \(StringUtil.nilChecker(carrier.carrierName ?? ""))")
                print("10. \(StringUtil.nilChecker(carrier.isoCountryCode ?? ""))")
                print("11. \(StringUtil.nilChecker(carrier.mobileCountryCode ?? ""))")
                print("12. \(StringUtil.nilChecker(carrier.mobileNetworkCode ?? ""))")
            }
            
            print("13. \(StringUtil.nilChecker(AppName()))")
            print("14. \(StringUtil.nilChecker(AppVersion()))")
            print("15. \(StringUtil.nilChecker(CountryCode()))")
            print("16. \(StringUtil.nilChecker(LanguageCode()))")
        }
        
        info[AppConstants.params.resolution] = DeviceInfoUtil.Resolution() as AnyObject
        info[AppConstants.params.appRunCount] =  StringUtil.nilChecker(CheckRunCount()) as AnyObject
        info[AppConstants.params.macAddress] = DeviceInfoUtil.MacAddress() as AnyObject
        info[AppConstants.params.osType] = AppConstants.OS_TYPE as AnyObject
        info[AppConstants.params.osVersion] = StringUtil.nilChecker(TheCurrentDevice.systemVersion) as AnyObject
        info[AppConstants.params.buildBrand] = AppConstants._BUILD_BRAND_ as AnyObject
        info[AppConstants.params.buildManufacturer] = AppConstants._BUILD_BRAND_ as AnyObject
        info[AppConstants.params.buildHardware] = StringUtil.nilChecker(TheCurrentDevice.name) as AnyObject
        info[AppConstants.params.buildModel] = StringUtil.nilChecker(TheCurrentDevice.model) as AnyObject
        info[AppConstants.params.buildDevice] = StringUtil.nilChecker(TheCurrentDevice.name) as AnyObject
        info[AppConstants.params.appName] = StringUtil.nilChecker(AppName()) as AnyObject
        info[AppConstants.params.buildVersionRelease] = StringUtil.nilChecker(AppVersion()) as AnyObject
        info[AppConstants.params.countryCd] = StringUtil.nilChecker(CountryCode()) as AnyObject
        info[AppConstants.params.language] = StringUtil.nilChecker(LanguageCode()) as AnyObject
        info[AppConstants.params.carrier] = StringUtil.nilChecker(CarrierName()) as AnyObject
        
        return info
    }
    
    static func UUIDString() -> String {
        return StringUtil.nilChecker((TheCurrentDevice.identifierForVendor?.uuidString)!)
    }
    
    static func IDFAString() -> String {
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                // Tracking authorization completed. Start loading ads here.
                // loadAd()
            })
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                let IDFA = ASIdentifierManager.shared().advertisingIdentifier as NSUUID
                
                return StringUtil.nilChecker(IDFA.uuidString)
            }
        }
        
        return UUIDString()
    }
    
    static func AppName() -> String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    static func AppVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static func AppBuild() -> String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    static func OSVersion() -> String {
        let os = ProcessInfo().operatingSystemVersion
        
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    static func Resolution() -> String {
        let bounds: CGRect = UIScreen.main.bounds
        let w:Int  = Int(bounds.size.width)
        let h:Int  = Int(bounds.size.height)
        
        return String(w) + "x" + String(h)
    }
    
    static func MacAddress() -> String {
        return UUIDString()
    }
    
    static func CountryCode() -> String {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) {
            return countryCode as! String
        }
        return ""
    }
    
    static func LanguageCode() -> String {
        let locale = Locale.current
        guard let languageCode = locale.languageCode,
            let regionCode = locale.regionCode else {
                return "kr_KR"
        }
        return languageCode + "_" + regionCode
    }
    
    static func CarrierName() -> String {
        
        if #available(iOS 12.0, *) {
            if let carriers:[String : CTCarrier] = TheTelephonyNetworkInfo.serviceSubscriberCellularProviders {
                if carriers.count > 0 {
                    if let carrier:CTCarrier = carriers["0000000100000001"] {
                    
                        if carrier.carrierName == nil {
                            return ""
                        }
                        
                        return carrier.carrierName!
                    }
                }
            }
        }
        else {
            if let carrier:CTCarrier = TheTelephonyNetworkInfo.subscriberCellularProvider {
                if carrier.carrierName == nil {
                    return ""
                }
                return carrier.carrierName!
            }
        }
        
        return ""
    }
    
    static func AddRunCount() {
        
        var count = UserDefaults.standard.integer(forKey: "appRunCount")
        count += 1
        
        UserDefaults.standard.set(count , forKey: "appRunCount")
    }
    
    static func CheckRunCount() -> String {
        
        let count = UserDefaults.standard.integer(forKey: "appRunCount")
        
        return String(count)
    }
    
    static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version:Float = Float(UIDevice.current.systemVersion)!
        }
        return Singleton.version
    }
    
    static var TheCurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }
    
    // MARK: - Device Idiom Checks
    
    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }
    
    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
        return "Debug"
        #else
        return "Release"
        #endif
    }
    
    static var SIMULATOR_OR_DEVICE: String {
        #if os(macOS)
        return "Simulator"
        #else
        return "Device"
        #endif
    }
    
    static func isPhone() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .phone
    }
    
    static func isPad() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .pad
    }
    
    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }
    
    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }
    
    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }
    
    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }
    
    // MARK: - Device Version Checks
    
    enum Versions: Float {
        case five = 5.0
        case six = 6.0
        case seven = 7.0
        case eight = 8.0
        case nine = 9.0
        case ten = 10.0
        case eleven = 11.0
    }
    
    static func isVersion(_ version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue && TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }
    
    static func isVersionOrLater(_ version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue
    }
    
    static func isVersionOrEarlier(_ version: Versions) -> Bool {
        return TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }
    
    static var CURRENT_VERSION: String {
        return "\(TheCurrentDeviceVersion)"
    }
    
    // MARK: iOS 5 Checks
    
    static func IS_OS_5() -> Bool {
        return isVersion(.five)
    }
    
    static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.five)
    }
    
    static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.five)
    }
    
    // MARK: iOS 6 Checks
    
    static func IS_OS_6() -> Bool {
        return isVersion(.six)
    }
    
    static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.six)
    }
    
    static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.six)
    }
    
    // MARK: iOS 7 Checks
    
    static func IS_OS_7() -> Bool {
        return isVersion(.seven)
    }
    
    static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.seven)
    }
    
    static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.seven)
    }
    
    // MARK: iOS 8 Checks
    
    static func IS_OS_8() -> Bool {
        return isVersion(.eight)
    }
    
    static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.eight)
    }
    
    static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.eight)
    }
    
    // MARK: iOS 9 Checks
    
    static func IS_OS_9() -> Bool {
        return isVersion(.nine)
    }
    
    static func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.nine)
    }
    
    static func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.nine)
    }
    
    // MARK: - Device Size Checks
    
    enum Heights: CGFloat {
        case inches_3_5 = 480
        case inches_4 = 568
        case inches_4_7 = 667
        case inches_5_5 = 736
    }
    
    static func isSize(_ height: Heights) -> Bool {
        return TheCurrentDeviceHeight == height.rawValue
    }
    
    static func isSizeOrLarger(_ height: Heights) -> Bool {
        return TheCurrentDeviceHeight >= height.rawValue
    }
    
    static func isSizeOrSmaller(_ height: Heights) -> Bool {
        return TheCurrentDeviceHeight <= height.rawValue
    }
    
    static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(TheCurrentDeviceHeight) Points"
    }
    
    // MARK: Retina Check
    
    static func IS_RETINA() -> Bool {
        return UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale))
    }
    
    // MARK: 3.5 Inch Checks
    
    static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(.inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.inches_3_5)
    }
    
    // MARK: 4 Inch Checks
    
    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(.inches_4)
    }
    
    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_4)
    }
    
    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.inches_4)
    }
    
    // MARK: 4.7 Inch Checks
    
    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(.inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_4_7)
    }
    
    // MARK: 5.5 Inch Checks
    
    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(.inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.inches_5_5)
    }
    
    // MARK: - International Checks
    
    static var CURRENT_REGION: String {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
    }
}
