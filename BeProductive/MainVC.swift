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
    var calenders: [EKCalendar]?
    var events: [EKEvent]?
    var dateFormat: DateFormat!
    
    // UI Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /* -- Implementation for UICollectionViewDataSource -- */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // Number of Items in Collection View - Depends on Number of Calendars
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return calenders!.count
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
        default:
            break
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
        calenders = eventStore.calendars(for: EKEntityType.event)
        for obj in calenders! {
            print(obj.title)
        }
    }
    
    /** Load Events of a Particular Calender using Title */
    func loadEvents() {
        let predicate = eventStore.predicateForEvents(withStart: Date().addingTimeInterval(-60*60*100), end: Date().addingTimeInterval(60*60*1000) , calendars: [calenders![2]])
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

