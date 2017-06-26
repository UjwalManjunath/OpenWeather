//
//  DateFormatterUtility.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    class func FormattedDateFromString(dateString:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: dateString)
        return date
        
    }
    
    class func FormattedStringFromDate(date:Date) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let string = dateFormatter.string(from: date)
        return string
    }
}
