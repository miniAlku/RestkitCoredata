//
//  ProgressReport.swift
//  RestkitSampleCoredata
//
//  Created by mini on 03/07/15.
//  Copyright (c) 2015 mini. All rights reserved.
//

import Foundation
import CoreData
@objc(ProgressReport)

class ProgressReport: NSManagedObject {

    @NSManaged var amount: String
    @NSManaged var bodyfat: String
    @NSManaged var calorie: String
    @NSManaged var calorie_burned: String
    @NSManaged var carb: String
    @NSManaged var exercise_type: String
    @NSManaged var fat: String
    @NSManaged var fibre: String
    @NSManaged var log_date: String
    @NSManaged var name: String
    @NSManaged var progress_type: String
    @NSManaged var protein: String
    @NSManaged var weight: String
    @NSManaged var progress: Progress

    class var entityMapping : RKEntityMapping {
        
        var progressLogMapping: RKEntityMapping = RKEntityMapping(forEntityForName: Constants.Tables.progressReportTable, inManagedObjectStore: RestKitManager.sharedManager().managedObjectStore)
        progressLogMapping .addAttributeMappingsFromDictionary(progressMappingDictionary)
        progressLogMapping.identificationAttributes = ["log_date"]
        
        return progressLogMapping
    }
    
    private class var progressMappingDictionary: [String : String] {
        
        return(["body_fat":"bodyfat", "calorie":"calorie", "calorie_burned":"calorie_burned", "carb":"carb", "fat":"fat", "fibre":"fibre", "log_date":"log_date", "name":"name", "protein":"protein", "weight":"weight", "type":"type", "amount":"amount"])
    }
}
