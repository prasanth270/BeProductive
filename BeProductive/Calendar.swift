//
//  Calendar.swift
//  BeProductive
//
//  Created by Prasanth Ramineni on 3/19/17.
//  Copyright © 2017 Prasanth Ramineni. All rights reserved.
//

import Foundation

class Calendar {
    
    private var _calendarInitials: String!
    private var _calendarName: String!
    
    var calendarInitials: String {
        set {
            _calendarName = newValue
        }
        get {
            return _calendarName
        }
    }
    
    var calendarName: String! {
        set {
            _calendarName = newValue
        }
        get {
            return _calendarName
        }
    }
    
    init(initial: String, name: String) {
        self._calendarInitials = initial
        self._calendarName = name
    }
}
