//
//  UserDietModel.swift
//  FlexYourMacros
//
//  Created by DBG-39 on 09/04/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

class UserDietModel: NSObject {
    
    var dietFormula: String?
    var dietCaloryType: String?
    var dietMacroType: String?
    var dietActivityLevel: String?
    var dietGoalOptionId: NSString?
    var dietNutritionalPlan: String?
    var dietCalories: String?
    var dietFiber: String?
    var numberOfMeals: String?
    var userDietMacroModel: UserDietMacroModel?
    
    
    class var objectMapping: RKObjectMapping {
        let dietMapping = RKObjectMapping(forClass: self)
        dietMapping.addAttributeMappingsFromDictionary(mappingDictionary)
        dietMapping.addPropertyMapping(UserDietModel.userDietMacroModelKeyMapping)
        return dietMapping
    }
    
    class var mappingDictionary: [String : String] {
        return(["diet_formula":"dietFormula", "diet_calory_type":"dietCaloryType", "diet_macro_type":"dietMacroType", "diet_activity_level":"dietActivityLevel", "diet_goal_option_id":"dietGoalOptionId", "diet_nutritional_plan":"dietNutritionalPlan", "diet_maintain_calories":"dietCalories", "diet_fiber":"dietFiber", "no_of_meals":"numberOfMeals"])
    }
    
    private class var userDietMacroModelKeyMapping : RKRelationshipMapping {
        return RKRelationshipMapping(fromKeyPath: Constants.ServiceConstants.keyPathUserDietOption, toKeyPath: "userDietMacroModel", withMapping: UserDietMacroModel.objectMapping)
    }
}