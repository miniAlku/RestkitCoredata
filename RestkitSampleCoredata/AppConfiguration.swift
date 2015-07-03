//
//  AppConfiguration.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 10/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

private let _AppConfiguration = AppConfiguration()

class AppConfiguration: NSObject {
    
    
    var userDetails: UserDetailModel? {
        didSet {
            //save user id in user credentials
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(userDetails!.userId!, forKey: "user_id")
            userDefaults.synchronize()
        }
    }
    var userDiet: UserDietModel?
    var userCredential: AccessTokenModel?
    
    class var sharedAppConfiguration: AppConfiguration {
        return _AppConfiguration
    }
    
}