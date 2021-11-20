//
//  NetworkUtil.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2018년 nextweb. All rights reserved.
//

import Foundation
import Alamofire

@objc
class NetworkUtil: NSObject {
    
    static func send(_ bindMap:Dictionary<String, Any>) {
        
        let encodedBindMap = StringUtil.encodeAsUtf8(bindMap)
        
        if AppConstants.CONSOLE_LOG {
            print("NetworkUtil send : \(encodedBindMap)")
        }
        
        sendPostHttp(encodedBindMap)
    }
    
    static func JSONParseArray(_ string: String) -> [Any]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [Any] {
                    return array
                }
            } catch let error {
                if AppConstants.CONSOLE_LOG {
                    print("JSONParseArray error: \(error)")
                }
            }
        }
        return [Any]()
    }
    
    static func sendPostHttp(_ bindMap:Dictionary<String, Any>) {
        
        AF.request(AppConstants.HTTP_URL, parameters: bindMap).validate().responseData {
            response in
            
            switch response.result {
            case .success:
                print("success")
                
                if AppConstants.CONSOLE_LOG {
                    print("response:%@", response.result);
                }
            case .failure(let e):
                
                if AppConstants.CONSOLE_LOG {
                    print("got an error: \(e)")
                }
            }
        }
    }
}
