//
//  MainVC.swift
//  BeProductive
//
//  Created by Prasanth Ramineni on 1/31/17.
//  Copyright © 2017 Prasanth Ramineni. All rights reserved.
//

import UIKit
import EventKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let eventStore = EKEventStore()
    var eventCalenders: [EKCalendar]?
    var events: [EKEvent]?
    var dateFormat: DateFormat!
    
    var calendars = [Calendar]()
    
    // UI Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    /* -- Implementation for UICollectionViewDataSource -- */
    
    /** Set Contents of a Calendar Cell */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            
            let calendar: Calendar!
            
            calendar = calendars[indexPath.row]
            
            cell.configureCell(_calendar: calendar)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    /** Number of Items in Collection View - Depends on Number of Calendars */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return calendars.count
    }
    
    /* -- Implementation for UICollectionViewDataSource -- */
    
    
    
    /** Executes before ViewDidLoad() */
    override func viewWillAppear(_ animated: Bool) {
        checkCalendarAccess()
    }
    
    
    /** Check for Calender Access before View Loads */
    func checkCalendarAccess() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch status {
        case EKAuthorizationStatus.notDetermined:
            requestAccess()
        case EKAuthorizationStatus.authorized:
            loadCalendar()
            //loadEvents()
            printData()
        default:
            break
        }
    }
    
    /** Print Function */
    func printData() {
        print(" ----")
        for obj in calendars {
            print(obj.calendarInitials)
            print(obj.calendarName)
        }
    }
    
    /** Request Access to Calendar */
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
    
    /** Retrieve Calenders */
    func loadCalendar() {
        eventCalenders = eventStore.calendars(for: EKEntityType.event)
        for obj in eventCalenders! {
            
            let title = obj.title
            //let index = title.index(title.startIndex, offsetBy: 1)
            print(title[0])
            
            // title[0] will return the first character of string based
            // on the extention written below.
            calendars.append(Calendar(initial: String(title[0]), name: title))
        }
    }
    
    /** Load Events of a Particular Calender using Title */
    func loadEvents() {
        let predicate = eventStore.predicateForEvents(withStart: Date().addingTimeInterval(-60*60*100), end: Date().addingTimeInterval(60*60*1000) , calendars: [eventCalenders![2]])
        self.events = eventStore.events(matching: predicate)
        if events != nil {
            for x in events! {
                if x.title == "Calendar" {
                  dateFormat = DateFormat(fromFormat: "GMT", toFormat: "PST", date: "\(x.startDate)")
                  dateFormat.formatDate()
                print(x.title)
                print(x.startDate)
                print(x.endDate)
                }
            }
        }
    }
}

/** Extentions? What are they? */
extension String {
    // Always return the first Character in a String
    subscript(index: Int) -> Character {
        return self[self.startIndex]
    }
}
