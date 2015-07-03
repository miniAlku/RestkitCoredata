//
//  ProgressLogModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 24/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

private let _ProgressResponse = ProgressResponse()

class ProgressResponse: NSObject {
    
    var meta: MetaModel?
    var results: Progress?
    var dailyResults: Progress?
    
    class var sharedProgressResponse: ProgressResponse {
        return _ProgressResponse
    }
    
    class var userResponseMapping: RKObjectMapping {
        
        let responseMapping = RKObjectMapping(forClass: self)
        
        // give referece to meta model
        responseMapping.addRelationshipMappingWithSourceKeyPath(Constants.ServiceConstants.keyPathMeta, mapping: MetaModel.objectMapping)
        
        // give reference to ProgressTypeMapping
        responseMapping.addRelationshipMappingWithSourceKeyPath("results", mapping: Progress.entityMapping)
        
        return responseMapping
    }
    
    class var responseDescriptor: RKResponseDescriptor {
        
        // create the response descriptor
        let responseDescriptor = RKResponseDescriptor(mapping: userResponseMapping, method: .GET, pathPattern: Constants.ServiceConstants.fetchProgressUrl, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful))
        return responseDescriptor
    }
    
    class func fetchUserProgressData(progressType: String, date: String, dateType: String, numberOfPages: String, completionHandler:(done: Bool)->(),completedWithError:(error: NSError)->() ) {
        
        RestKitManager.setToken(true)

        var parameterDictionary: [String:String] {
            // create the parameter dictionary
            return ["progress_type": progressType, "progress_date": date, "progress_date_type": dateType, "progress_page_count": numberOfPages]
        }
        
        // get the objects from the path login
        RestKitManager.sharedManager().getObjectsAtPath(Constants.ServiceConstants.fetchProgressUrl, parameters: parameterDictionary, success: { (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) in
            
            // get the user response
            let progressResponse = mappingResult.firstObject as! ProgressResponse
            
            //check for success
            if progressResponse.meta?.responseCode != 200 {
                return;
            }
            
            completionHandler(done: true)
                        
                        
            }, failure: { (operation: RKObjectRequestOperation!, error: NSError!) -> Void in
            
                completedWithError(error: error)
                println("failed to load masterdata with error \(error)")
        })
    }
    

}