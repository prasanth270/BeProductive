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
        
        configureContentInCell()
        
        self.calendarInitialsTextView.text = self.calendar.calendarInitials.capitalized
        self.calendarNameTextView.text = self.calendar.calendarName
    }
    
    func configureContentInCell() {
        self.calendarInitialsTextView.isEditable = false
        self.calendarNameTextView.isEnabled = false
        self.calendarNameTextView.textAlignment = NSTextAlignment.center
    }
}
