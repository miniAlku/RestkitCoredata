//
//  AccessTokenModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 09/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

class AccessTokenModel: NSObject {
    
    var accessToken: String? {
        didSet {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults .setObject(self.accessToken, forKey: "accesstoken")
            
            //set user session active when accesstoken is set
            userDefaults.setObject("Active", forKey: "session")
            userDefaults.setValue(NSDate(), forKey: "accesstoken_setdate")

            userDefaults.synchronize()
            
        }
    }
    
    var expiresIn: NSNumber? {
        didSet {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults .setObject(String(format:"%f", self.expiresIn!.doubleValue), forKey: "expiresin")
            userDefaults.synchronize()
        }
    }
    
    var tokenType: String? {
        didSet {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults .setObject(self.tokenType, forKey: "tokenType")
            userDefaults.synchronize()
        }
    }
    
    var refreshToken: String? {
        didSet {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults .setObject(self.refreshToken, forKey: "refreshtoken")
            userDefaults.synchronize()
        }
    }
    
    class var objectMapping: RKObjectMapping {
        let tokenMapping = RKObjectMapping(forClass: self)
        tokenMapping.addAttributeMappingsFromDictionary(AccessTokenModel.mappingDictionary)
        return tokenMapping
    }
    
    class var mappingDictionary: [String : String] {
        return(["access_token":"accessToken", "expires_in":"expiresIn", "token_type":"tokenType", "refresh_token":"refreshToken"])
    }
    
}