//
//  DateFormat.swift
//  BeProductive
//
//  Created by Prasanth Ramineni on 2/6/17.
//  Copyright © 2017 Prasanth Ramineni. All rights reserved.
//

import Foundation

class DateFormat {
    
    private var _fromFormat: String!
    private var _toFormat: String!
    private var _date: String!
    
    init(fromFormat: String, toFormat: String, date: String) {
        self._fromFormat = fromFormat
        self._toFormat = toFormat
        self._date = date
    }
    
    func formatDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: self._fromFormat) as? TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let date = dateFormatter.date(from: self._date)!
        print("\(_fromFormat):: \(date)")
        
        let toDateFormatter = DateFormatter()
        toDateFormatter.timeZone = NSTimeZone(name: self._toFormat) as? TimeZone
        toDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        print("\(_toFormat):: \(toDateFormatter.string(from: date))")
        
    }
}
