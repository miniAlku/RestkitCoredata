//
//  UserDietMacroModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 10/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

class UserDietMacroModel: NSObject {
    
    var dietMacroFat: String?
    var dietMacroProtein: String?
    var dietMacroCarbs: String?
    
    class var objectMapping: RKObjectMapping {
        let dietMapping = RKObjectMapping(forClass: self)
        dietMapping.addAttributeMappingsFromDictionary(mappingDictionary)
        return dietMapping
    }
    
    class var mappingDictionary: [String : String] {
        return(["diet_macro_fat":"dietMacroFat", "diet_macro_protein":"dietMacroProtein", "diet_macro_carbs":"dietMacroCarbs"])
    }
}