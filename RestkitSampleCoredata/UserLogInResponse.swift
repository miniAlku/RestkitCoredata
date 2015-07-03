//
//  AccessTokenModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 09/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

private let _UserLogInResponse = UserLogInResponse()

class UserLogInResponse: NSObject {
    
    var accessTokenModel: AccessTokenModel?
    var userDietModel: UserDietModel?
    var userDetailModel: UserDetailModel?
    var metaModel: MetaModel?
    
    class var sharedUserLogInResponse: UserLogInResponse {
        return _UserLogInResponse
    }
    
    class var userResponseMapping: RKObjectMapping {
        
        let responseMapping = RKObjectMapping(forClass: self)
        
        // give referece to meta model
        responseMapping.addPropertyMapping(UserLogInResponse.metaModelKeyMapping)
        
        // give reference to accesstoken mapping
        responseMapping.addPropertyMapping(UserLogInResponse.accessTokenModelKeyMapping)
        
        // give reference to diet mapping
        responseMapping.addPropertyMapping(UserLogInResponse.userDietModelKeyMapping)
        
        // give reference to user credential mapping
        responseMapping.addPropertyMapping(UserLogInResponse.userDetailModelKeyMapping)
        
        return responseMapping
    }
    
    class var responseDescriptor: RKResponseDescriptor {
        
        // create the response descriptor
        let responseDescriptor = RKResponseDescriptor(mapping: userResponseMapping, method: .POST, pathPattern: Constants.ServiceConstants.logInUrl, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful))
        return responseDescriptor
    }
    
    private class var metaModelKeyMapping : RKRelationshipMapping {
        
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathMeta, toKeyPath: "metaModel", withMapping: MetaModel.objectMapping)
    }
    
    private class var accessTokenModelKeyMapping : RKRelationshipMapping {
        
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathAccessToken, toKeyPath: "accessTokenModel", withMapping: AccessTokenModel.objectMapping)
    }
    
    private class var userDietModelKeyMapping : RKRelationshipMapping {
        
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathUserDiet, toKeyPath: "userDietModel", withMapping: UserDietModel.objectMapping)
    }
    
    private class var userDetailModelKeyMapping : RKRelationshipMapping {
        
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathUserDetail, toKeyPath: "userDetailModel", withMapping: UserDetailModel.objectMapping)
    }
    
    
    
    class func logInUser(username: String, password: String, completionHandler: (accessCredential: AccessTokenModel, userDiet: UserDietModel, userDetails: UserDetailModel) -> (), failedWithError: (error: String) -> ()) {
        
    
        // add loading indicator
//       MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
//        SVProgressHUD.show()

        
        var parameterDictionary: [String:String] {
            // save useremail and password for a session
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(username, forKey: "username")
            userDefaults.setObject(password, forKey: "password")
            userDefaults.synchronize()
             
            // create the parameter dictionary
            return ["username":username, "password":password, "grant_type":"password"]
        }
       
        // get the objects from the path login
        RKObjectManager.sharedManager().postObject(nil, path: Constants.ServiceConstants.logInUrl, parameters: parameterDictionary, success: { (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) in
            
            // remove loading indicator
//            MBProgressHUD.hideHUDForView(viewController.view, animated: true)
//            SVProgressHUD.dismiss()

            
            // get the user response
            let userLogInResonse = mappingResult.firstObject as! UserLogInResponse
            
            // check for success
            if userLogInResonse.metaModel?.responseCode != 200 {
                
                var errorMessage = userLogInResonse.metaModel?.message ?? ""
                let errorMessages = userLogInResonse.metaModel?.errormessages
                if errorMessages!.isEmpty {
                    
                } else {
                    
                    errorMessage = errorMessages?.first?.fieldMessage ?? ""
                }
                failedWithError(error: errorMessage)
                return
            }
            
            // set up the completion handler with response
            completionHandler(accessCredential: userLogInResonse.accessTokenModel!, userDiet: userLogInResonse.userDietModel!, userDetails: userLogInResonse.userDetailModel!)
            
        println("accessTokenModel in \(userLogInResonse.accessTokenModel?.accessToken)")
            
        }, failure: { (operation: RKObjectRequestOperation!, error: NSError!) -> Void in
            
            // remove loading indicator
//            MBProgressHUD.hideHUDForView(viewController.view, animated: true)
//            SVProgressHUD.dismiss()

            failedWithError(error: error.localizedDescription)
        println("failed to load login with error \(error)")
        })
    }
    
    
}