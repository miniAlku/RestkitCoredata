//
//  MetaModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 10/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

class MetaModel: NSObject {
    
    var responseStatus: String?
    var responseCode: NSNumber?
    var message: String = ""
    var errormessages: [MetaError] = [MetaError]()
    
    class var objectMapping: RKObjectMapping {
        let metaMapping = RKObjectMapping(forClass: self)
        metaMapping.addAttributeMappingsFromDictionary(mappingDictionary)
        // give reference to accesstoken mapping
        metaMapping.addPropertyMapping(MetaModel.errorMessageMapping)
        return metaMapping
    }
    
    private class var errorMessageMapping : RKRelationshipMapping {
        
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathErrorMessage, toKeyPath: "errormessages", withMapping: MetaError.objectMapping)
    }
    
    class var mappingDictionary: [String : String] {
        return(["status":"responseStatus", "code":"responseCode", "message" : "message"])
    }
}

class MetaError: NSObject {
    
    var field: String = ""
    var fieldMessage: String = ""
    
    class var objectMapping: RKObjectMapping {
        let metaMapping = RKObjectMapping(forClass: self)
        metaMapping.addAttributeMappingsFromDictionary(mappingDictionary)
        return metaMapping
    }
    
    class var mappingDictionary: [String : String] {
        return(["field":"field", "message":"fieldMessage"])
    }
}