//
//  MainVC.swift
//  BeProductive
//
//  Created by Prasanth Ramineni on 1/31/17.
//  Copyright © 2017 Prasanth Ramineni. All rights reserved.
//

import UIKit
import EventKit

class MainVC: UIViewController {
    
    let eventStore = EKEventStore()
    var calenders: [EKCalendar]?
    var events: [EKEvent]?
    var dateFormat: DateFormat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkCalendarAccess()
    }
    
    func checkCalendarAccess() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch status {
        case EKAuthorizationStatus.notDetermined:
            requestAccess()
        case EKAuthorizationStatus.authorized:
            loadCalendar()
            //loadEvents()
        default:
            break
        }
    }
    
    func requestAccess() {
        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            if accessGranted {
                print("Access Granted")
                self.loadCalendar()
            } else {
                print("Access Denied")
                
            }
        }
    }
    
    func loadCalendar() {
        calenders = eventStore.calendars(for: EKEntityType.event)
        for obj in calenders! {
            print(obj.title)
        }
    }
    
    func loadEvents() {

        let predicate = eventStore.predicateForEvents(withStart: Date().addingTimeInterval(-60*60*100), end: Date().addingTimeInterval(60*60*100) , calendars: nil)
        self.events = eventStore.events(matching: predicate)
        if events != nil {
            for x in events! {
                if x.title == "Student Assistant shift at San Jose State University" {
                    dateFormat = DateFormat(fromFormat: "GMT", toFormat: "PST", date: "\(x.startDate)")
                    dateFormat.formatDate()
//                print(x.title)
//                print(x.startDate)
//                print(x.endDate)
                }
            }
        }
    }

}

