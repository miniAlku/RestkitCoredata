//
//  NSString.swift
//  FlexYourMacros
//
//  Created by Thahir Maheen on 27/03/15.
//  Copyright (c) 2015 Digital Brand Group. All rights reserved.
//

import Foundation

// MARK: Localization
prefix operator && {}

prefix func && (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

// MARK: Filtering
extension String {
    
    func filterWordsWithPrefix(prefix: String, shouldStripPrefix: Bool) -> [String] {
        
        // the regular expression to filter out words
        let regularExpression = NSRegularExpression(pattern: "\(prefix)(\\w+)", options: .CaseInsensitive, error: nil)!
        
        // filter out results using the regular expression
        let arrayMatches = regularExpression.matchesInString(self, options: .WithTransparentBounds, range: NSMakeRange(0, count(self)))
        
        // return words from results
        return arrayMatches.map() {
            (self as NSString).substringWithRange($0.rangeAtIndex(shouldStripPrefix ? 1 : 0))
        }
    }
    
    func filterHashTags() -> [String] {
        return filterWordsWithPrefix("#", shouldStripPrefix: false)
    }
    
    func contains(find: String) -> Bool {
        return self.rangeOfString(find, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil
    }
    
    func trimmedString() -> String {
        
        // trim white spaces and new lines
        var trimmedText = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // remove new lines throughout the text
        trimmedText = trimmedText.stringByReplacingOccurrencesOfString("\n", withString: "")
            
        return trimmedText
    }
    
}

// MARK: Date
extension String {
    
    // dateFormat has precedence over dateStyle
    // date style defaults to LongStyle
    func dateValue(dateFormat: String? = nil, dateStyle: NSDateFormatterStyle? = nil) -> NSDate? {
        
        // get a date formatter
        let dateFormatter = NSDateFormatter()
        
        // set appropriate date styles/formats
        if let dateFormat = dateFormat {
            dateFormatter.dateFormat = dateFormat
        }
        else if let dateStyle = dateStyle {
            dateFormatter.dateStyle = dateStyle
        }
        else {
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        }
        
        // return the date after formatting
        return dateFormatter.dateFromString(self)
    }
    
    func utcDateValue(dateFormat: String? = nil, dateStyle: NSDateFormatterStyle? = nil) -> NSDate? {
        
        // get a date formatter
        let dateFormatter = NSDateFormatter()
        
        // set appropriate date styles/formats
        if let dateFormat = dateFormat {
            dateFormatter.dateFormat = dateFormat
        }
        else if let dateStyle = dateStyle {
            dateFormatter.dateStyle = dateStyle
        }
        else {
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        }
        
        // set gmt 0
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        // return the date after formatting
        return dateFormatter.dateFromString(self)
    }
    
    func websiteString() -> (valid: Bool, urlString: String) {
        
        let urlRegExWithPrefix = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTestWithPrefix = NSPredicate(format: "SELF MATCHES %@",urlRegExWithPrefix)
        var isValid = urlTestWithPrefix.evaluateWithObject(self)
        var urlString = self
        
        if !isValid {
            
            let urlRegEx = "(www\\.)[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
            let urlTest = NSPredicate(format: "SELF MATCHES %@",urlRegEx)
            isValid = urlTest.evaluateWithObject(self)
            
            urlString = "http://"+self
            
        }
        
        return (isValid, urlString)
    }
}

extension String {
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var singleDecimalValue: String {
        return NSString(format: "%.1f", (self as NSString).floatValue) as String
    }
    
}