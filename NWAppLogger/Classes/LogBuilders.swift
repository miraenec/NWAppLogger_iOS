//
//  LogBuilders.swift
//  NWAppLogFramework
//
//  Created by nextweb on 2018. 1. 3..
//  Copyright © 2018년 nextweb. All rights reserved.
//

import Foundation

@objc
public class LogBuilders : NSObject {
    
    public func build(_ bindMap:Dictionary<String, String>) -> Dictionary<String, String>{
        return bindMap
    }
    
    @objc
    public class EventLogBuilder : NSObject {
        fileprivate static var bindMap:Dictionary<String, String>?
        
        public static func setEvent(_ type:String) -> Event {
            bindMap = Dictionary<String, String>()
            return Event(type: type);
        }
        
        public static func setEvent(_ type:String, desc:String) -> Event {
            bindMap = Dictionary<String, String>()
            return Event(type: type, desc: desc)
        }
        
        @objc
        public class Event : NSObject{
            init(type: String) {
                bindMap![AppConstants.params.evtType] = type
            }
            
            init(type: String, desc: String) {
                bindMap![AppConstants.params.evtType] = type
                bindMap![AppConstants.params.evtDesc] = desc
            }
            
            public func build() -> Dictionary<String, String> {
                return bindMap!
            }
            
            public func setCategory(_ id:String) -> Category {
                return Category(id: id)
            }
            
            public class Category {
                init(id:String) {
                    bindMap![AppConstants.params.cateId] = id
                }
                
                public func build() -> Dictionary<String, String> {
                    return bindMap!
                }
            }
        }
    }
}
