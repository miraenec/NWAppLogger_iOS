//
//  Constants.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2018년 nextweb. All rights reserved.
//

import Foundation

@objc
public class AppConstants : NSObject {

    @objc static var CONSOLE_LOG:Bool = true

    @objc static var HTTP_URL:String = ""
    @objc static let httpUrl_dev:String = ""
    @objc static let httpUrl:String = HTTP_URL

    @objc static let configFileName:String = "NxtConf"
    @objc static let OS_TYPE:String = "iOS"
    @objc static let _BUILD_BRAND_:String = "apple"
    @objc static let DATABASE_NAME:String = "NWLogger_DB"
    @objc static let TABLE_NAME:String = "tb_usage_logger"
    
    @objc dynamic static let _APP_START_:String = "APP_START"
    @objc dynamic static let _APP_FINISH_:String = "APP_FINISH"
    @objc dynamic static let _APP_PAUSE_:String = "APP_PAUSE"
    @objc dynamic static let _APP_RESUME_:String = "APP_RESUME"
    @objc dynamic static let _SEARCH_:String = "SEARCH"
    @objc dynamic static let _HOME_:String = "HOME"
    @objc dynamic static let _CONFIG_:String = "CONFIG"
    @objc dynamic static let _PREV_BTN_:String = "PREV_BTN"
    @objc dynamic static let _BTN_CLICK_:String = "BTN_CLICK"
    @objc dynamic static let _SCROLL_:String = "SCROLL"
    @objc dynamic static let _ZOOM_:String = "ZOOM"
    @objc dynamic static let _MENU_CLICK_:String = "MENU_CLICK"
    @objc dynamic static let _AV_PLAY_:String = "AV_PLAY"
    
    struct params {
        static let ct:String = "ct"                         // 로그생성시간
        static let st:String = "st"                         // 로그전송시간
        static let osType:String = "osType"                 // OS 종류
        static let osVersion:String = "osVersion"           // OS 버전
        static let apiKey:String = "apiKey"                 // apiKey
        static let appName:String = "appName"               // 앱이름
        static let packageName:String = "packageName"       // 패키지명
        static let className:String = "className"           // 클래스명
        static let xtVid:String = "xtVid"                   // IDFA
        static let xtDid:String = "xtDid"                   // UUID
        static let xtUid:String = "xtUid"                   // 서비스 로그인 아이디
        static let ssId:String = "ssId"                     // 세션 아이디
        static let evtType:String = "evtType"               // 이벤트 형태
        static let evtDesc:String = "evtDesc"               // 이벤트 설명
        static let cateId:String = "cateId"                 // 카테고리
        
        static let macAddress:String = "macAddress"         // 맥주소
        static let resolution:String = "resolution"         // 해상도
        static let appRunCount:String = "appRunCount"       // 앱실행수
        
        static let buildBoard:String = "buildBoard"
        static let buildBrand:String = "buildBrand"
        static let buildDevice:String = "buildDevice"
        static let buildDisplay:String = "buildDisplay"
        static let buildFingerprint:String = "buildFingerprint"
        static let buildHost:String = "buildHost"
        static let buildId:String = "buildId"
        static let buildManufacturer:String = "buildManufacturer"
        static let buildModel:String = "buildModel"
        static let buildProduct:String = "buildProduct"
        static let buildSerial:String = "buildSerial"
        static let buildTags:String = "buildTags"
        static let buildTime:String = "buildTime"
        static let buildType:String = "buildType"
        static let buildUser:String = "buildUser"
        static let buildVersionRelease:String = "buildVersionRelease"
        static let buildVersionSdkInt:String = "buildVersionSdkInt"
        static let buildVersionCodename:String = "buildVersionCodename"
        static let buildHardware:String = "buildHardware"
        
        // 추가된 항목
        static let countryCd:String = "countryCd"               // 국가코드
        static let language:String = "language"                 // 언어정보
        static let carrier:String = "carrier"                   // 통신사 정보
    }
}
