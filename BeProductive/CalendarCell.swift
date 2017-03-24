//
//  CalendarCell.swift
//  BeProductive
//
//  Created by Prasanth Ramineni on 3/19/17.
//  Copyright © 2017 Prasanth Ramineni. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var calendarInitialsTextView: UITextView!
    
    @IBOutlet weak var calendarNameTextView: UITextField!
    
    var calendar: Calendar!
    
    /** Display Contents in a Cell */
    func configureCell(_calendar: Calendar) {
        self.calendar = _calendar
        
        calendarInitialsTextView.text = self.calendar.calendarInitials.capitalized
        calendarNameTextView.text = self.calendar.calendarName
    }
    
    
}
