//
//  Progress.swift
//  RestkitSampleCoredata
//
//  Created by mini on 03/07/15.
//  Copyright (c) 2015 mini. All rights reserved.
//

import Foundation
import CoreData
@objc(Progress)

class Progress: NSManagedObject {

    @NSManaged var type: String
    @NSManaged var report: NSSet

    
    class var entityMapping : RKEntityMapping {
        
        var progressMapping: RKEntityMapping = RKEntityMapping(forEntityForName: Constants.Tables.progressTable, inManagedObjectStore: RestKitManager.sharedManager().managedObjectStore)
        //set up the identification attribute
        progressMapping.identificationAttributes = ["type"]
        
        progressMapping .addAttributeMappingsFromDictionary(progressMappingDictionary)
        progressMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "report", toKeyPath: "report", withMapping: ProgressReport.entityMapping))
       
        return progressMapping
    }
    
    private class var progressMappingDictionary: [String : String] {
        
        return(["type":"type"])
    }
    
    class func fetchProgressDataFromUrl(progressType: String, date: String, dateType: String, numberOfPages: String, completionHandler:(done: Bool)->(), completedWithError:(error: NSError)->()) {
        
        ProgressResponse.fetchUserProgressData(progressType, date: date, dateType: dateType, numberOfPages: numberOfPages, completionHandler: { (done) -> () in
            completionHandler(done: done)
            }) { (error) -> () in
                completedWithError(error: error)
        }
        
    }
    
}
