import Foundation

@objc
public class NWAppLogger : NSObject {
    
    fileprivate var xtUid:String = ""
    fileprivate var ssId:String = ""
    
    public static let shared = NWAppLogger()
    
    @objc
    public func initLogger(_ obj:AnyObject, url:String, isLog:Bool, userInfo:Dictionary<String,AnyObject>) {
        
        setUrl(url)
        setPrintLog(isLog)
        if let uid = userInfo["uid"] {
            setUserId(uid as? String ?? "")
        }
        if let ssid = userInfo["ssid"] {
            setSessionId(ssid as? String ?? "")
        }
    }
    
    @objc
    public func setPrintLog(_ isPrint:Bool) {
        AppConstants.CONSOLE_LOG = isPrint
        
        print("[NWAppLogger] Log is \(isPrint ? "ON" : "OFF")")
    }
    
    @objc
    private func setUrl(_ url:String) {
        AppConstants.HTTP_URL = url
    }
    
    @objc
    private func setUserId(_ uid:String) {
        xtUid = uid
    }
    
    @objc
    private func setSessionId(_ ssid:String) {
        ssId = ssid
    }
    
    @objc
    public func sendLog(_ obj:AnyObject, paramMap:Dictionary<String, AnyObject>) -> String {
        var defaultParamMap:Dictionary<String, AnyObject> = getDefaultParams(obj)
        
        for key in paramMap.keys {
            defaultParamMap[key] = paramMap[key]
        }
        
        defaultParamMap[AppConstants.params.st] = CalendarUtil.currentMilliSecond()
        
        NetworkUtil.send(defaultParamMap)
        
        return defaultParamMap.description
    }
    
    @objc
    public func sendLog(_ className:String, packageName:String, paramMap:Dictionary<String, AnyObject>) {
        var defaultParamMap:Dictionary<String, AnyObject> = getDefaultParams(className, packageName: packageName)
        
        for key in paramMap.keys {
            defaultParamMap[key] = paramMap[key]
        }
        
        defaultParamMap[AppConstants.params.st] = CalendarUtil.currentMilliSecond()
        
        NetworkUtil.send(defaultParamMap)
    }
    
    @objc
    public func clear(_ className:String, packageName:String) {
        sendAppEndLog(className, packageName: packageName)
    }
    
    @objc
    public func resume(_ className:String, packageName:String) {
        sendAppResumeLog(className, packageName: packageName)
    }
    
    @objc
    public func pause(_ className:String, packageName:String) {
        sendAppOnPauseLog(className, packageName: packageName)
    }
    
    @objc
    public func start(_ obj:AnyObject) {
        sendAppStartLog(obj)
    }
    
    @objc
    public func clear(_ obj:AnyObject) {
        sendAppEndLog(obj)
    }
    
    @objc
    public func resume(_ obj:AnyObject) {
        perform(#selector(NWAppLogger.sendAppResumeLog(_:)), with: obj, afterDelay: 0.2)
    }
    
    @objc
    public func pause(_ obj:AnyObject) {
        sendAppOnPauseLog(obj)
    }
    
    @objc
    public func getDefaultParams(_ obj:AnyObject) -> Dictionary<String, AnyObject> {
        
        var bindMap = Dictionary<String, AnyObject>()
        
        bindMap[AppConstants.params.ct] = CalendarUtil.currentMilliSecond()
        bindMap[AppConstants.params.xtVid] = DeviceInfoUtil.IDFAString() as AnyObject
        bindMap[AppConstants.params.xtDid] = DeviceInfoUtil.UUIDString() as AnyObject
        bindMap[AppConstants.params.xtUid] = xtUid as AnyObject
        bindMap[AppConstants.params.ssId] = ssId as AnyObject
        
        if AppConstants.CONSOLE_LOG {
            print("\(#function) in \(type(of: self))")
            print("0. \(StringUtil.nilChecker(AppConstants.HTTP_URL))")
            print("1. \(StringUtil.nilChecker(bindMap[AppConstants.params.xtVid] as! String))")
            print("2. \(StringUtil.nilChecker(bindMap[AppConstants.params.xtDid] as! String))")
            print("3. \(StringUtil.nilChecker(xtUid))")
            print("4. \(StringUtil.nilChecker(ssId))")
        }
        
        let devideInfoMap = DeviceInfoUtil.deviceInfo()
        for key in devideInfoMap.keys {
            bindMap[key] = devideInfoMap[key]
        }
        
        let appInfoMap = AppInfoUtil.appInfo(obj)
        for key in appInfoMap.keys {
            bindMap[key] = appInfoMap[key]
        }
        
        return bindMap
    }
    
    @objc
    public func getDefaultParams(_ className:String, packageName:String) -> Dictionary<String, AnyObject> {
        
        var bindMap = Dictionary<String, AnyObject>()
        
        bindMap[AppConstants.params.ct] = CalendarUtil.currentMilliSecond()
        bindMap[AppConstants.params.xtVid] = DeviceInfoUtil.IDFAString() as AnyObject
        bindMap[AppConstants.params.xtDid] = DeviceInfoUtil.UUIDString() as AnyObject
        bindMap[AppConstants.params.xtUid] = xtUid as AnyObject
        
        if AppConstants.CONSOLE_LOG {
            print("\(#function) in \(type(of: self))")
            print("1. \(StringUtil.nilChecker(bindMap[AppConstants.params.xtVid] as! String))")
            print("2. \(StringUtil.nilChecker(bindMap[AppConstants.params.xtDid] as! String))")
            print("3. \(StringUtil.nilChecker(xtUid))")
            print("4. \(StringUtil.nilChecker(ssId))")
        }
        
        let devideInfoMap = DeviceInfoUtil.deviceInfo()
        for key in devideInfoMap.keys {
            bindMap[key] = devideInfoMap[key]
        }
        
        let appInfoMap = AppInfoUtil.appInfo(className, packageName: packageName)
        for key in appInfoMap.keys {
            bindMap[key] = appInfoMap[key]
        }
        
        return bindMap
    }
    
    @objc
    public func sendAppStartLog(_ className:String, packageName:String) {
        DeviceInfoUtil.AddRunCount()
        sendLog(className, packageName: packageName, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_START_, desc: "onCreate").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppEndLog(_ className:String, packageName:String) {
        sendLog(className, packageName: packageName, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_FINISH_, desc: "onDestroy").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppOnPauseLog(_ className:String, packageName:String) {
        sendLog(className, packageName: packageName, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_PAUSE_, desc: "onPause").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppResumeLog(_ className:String, packageName:String) {
        sendLog(className, packageName: packageName, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_RESUME_, desc: "onResume").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppStartLog(_ obj:AnyObject) {
        DeviceInfoUtil.AddRunCount()
        _ = sendLog(obj, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_START_, desc: "onCreate").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppEndLog(_ obj:AnyObject) {
        _ = sendLog(obj, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_FINISH_, desc: "onDestroy").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppOnPauseLog(_ obj:AnyObject) {
        _ = sendLog(obj, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_PAUSE_, desc: "onPause").build() as Dictionary<String, AnyObject>)
    }
    
    @objc
    public func sendAppResumeLog(_ obj:AnyObject) {
        _ = sendLog(obj, paramMap: LogBuilders.EventLogBuilder.setEvent(AppConstants._APP_RESUME_, desc: "onResume").build() as Dictionary<String, AnyObject>)
    }
}
