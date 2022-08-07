//
//  AppleCalenderTest.swift
//  Calendar
//
//  Created by Ankush Gupta on 06/08/22.
//

import Foundation
import EventKit

struct ReminderPermissions {
  
  // Initialize permission store
  let store: EKEventStore
  let reminder: EKEntityType = .reminder
  
  private init() {
    store = EKEventStore()
  }
  
  private func requestPermissions() {
    let permissions = EKEventStore.authorizationStatus(for: reminder)
    switch permissions {
    case .notDetermined:
      store.requestAccess(to: reminder) {
        (granted: Bool, error: Error?) in
        if granted {
          self.pastDate()
        } else {
          // throw a popup asking for permissions
          // displayErrorPopup()
        }
      }
    case .restricted, .denied:
      print("Permission toh dena padega meri Jaan")
    case .authorized:
      print("Yay!! Nacho BC")
    default:
      print("Something something \\(-|-)/")
    }
  }
  
  func pastDate() {
    let calender = Calendar.current
    
    var yesterdayComponent = DateComponents()
    yesterdayComponent.day = -1
    let yesterday = calender.date(byAdding: yesterdayComponent, to: Date(), wrappingComponents: false)
    
    var oneYearAgoComponent = DateComponents()
    oneYearAgoComponent.year = 1
    let oneYearAgo = calender.date(byAdding: oneYearAgoComponent, to: Date(), wrappingComponents: false)
    
    var predicate: NSPredicate? = nil
    if let anAgo = yesterday, let aNow = oneYearAgo {
      predicate = store.predicateForEvents(withStart: anAgo, end: aNow, calendars: nil)
    }
    var events: [EKEvent]? = nil
    if let aPredicate = predicate {
      events = store.events(matching: aPredicate)
    }
    print("REM Events found!!!!!")
    print(events)
  }
}

struct CalendarPermissions {
  let store: EKEventStore
  let event: EKEntityType = .event
  
  private init() {
    store = EKEventStore()
  }
  
  private func requestPermissions() {
    let permissions = EKEventStore.authorizationStatus(for: event)
    switch permissions {
    case .notDetermined:
      store.requestAccess(to: event) {
        (granted: Bool, error: Error?) in
        if granted {
          self.pastDate()
        } else {
          // throw a popup asking for permissions
          // displayErrorPopup()
        }
        
      }
    case .restricted, .denied:
      print("Permission toh dena padega meri Jaan")
    case .authorized:
      print("Yay!! Nacho BC")
    default:
      print("Something something \\(-|-)/")
    }
  }
  
  func pastDate() {
    let calender = Calendar.current
    
    var yesterdayComponent = DateComponents()
    yesterdayComponent.day = -1
    let yesterday = calender.date(byAdding: yesterdayComponent, to: Date(), wrappingComponents: false)
    
    var oneYearAgoComponent = DateComponents()
    oneYearAgoComponent.year = 1
    let oneYearAgo = calender.date(byAdding: oneYearAgoComponent, to: Date(), wrappingComponents: false)
    
    var predicate: NSPredicate? = nil
    if let anAgo = yesterday, let aNow = oneYearAgo {
      predicate = store.predicateForEvents(withStart: anAgo, end: aNow, calendars: nil)
    }
    var events: [EKEvent]? = nil
    if let aPredicate = predicate {
      events = store.events(matching: aPredicate)
    }
    print"CAL Events found!!!!!")
    print(events)
  }
}
