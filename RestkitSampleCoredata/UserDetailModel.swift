//
//  UserSignUpModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 14/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

class UserDetailModel: NSObject {
    
    var userFymId: String?
    var userId: String?
    var friendId: String?
    var userFirstName: String?
    var userLastName: String?
    var userUserName: String?
    var userEmail: String?
    var userWebsite: String?
    var userFbId: String?
    var userGender: String?
    var userProfilePhoto: NSString?//NSObject = ""
    var userDob: String?
    var userHeight: String?
    var userWeight: String?
    var userFat: String?
    var userFacebookId: String?
    
    // parameters for the user
    var following:String?
    var followers:String?
    var status:String?
   
    // parameter for the profile-type
    var userType:String?
    
    // parameter for the description
    var userDescription: NSString?
    
    // parameter for the profile status - follow/unfollow/pending
    var followStatus:String?
    var friendStatus:String?
    //to be changed
    var userPushNotificationStatus: String = "Yes"
    
    class var objectMapping: RKObjectMapping {
        let dietMapping = RKObjectMapping(forClass: self)
        dietMapping.addAttributeMappingsFromDictionary(mappingDictionary)
        return dietMapping
    }
    
    class var mappingDictionary: [String : String] {
        return(["id":"userFymId", "user_id":"userId", "first_name":"userFirstName", "last_name":"userLastName", "user_name":"userUserName", "email":"userEmail", "website":"userWebsite", "gender":"userGender", "profile_photo":"userProfilePhoto", "dob":"userDob", "height":"userHeight", "weight":"userWeight", "fat":"userFat","following":"following","followers":"followers","status":"status","user_type":"userType","follow_status":"followStatus","friend_status":"friendStatus","description":"userDescription", "facebook_id": "userFacebookId"])
    }
}