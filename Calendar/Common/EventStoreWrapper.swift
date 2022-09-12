//
//  EventStoreWrapper.swift
//  Calendar
//
//  Created by Ankush Gupta on 07/08/22.
//

import EventKit

class EventStoreWrapper: PermissionInterface {
  let store: EKEventStore
  var event: EKEntityType
  
  private let calendar = Calendar.current
  
  init(_ event: EKEntityType) {
    self.event = event
    self.store = EKEventStore()
  }
  
  func requestPermissions() -> (title: String, message: String) {
    let permissions = EKEventStore.authorizationStatus(for: self.event)
    switch permissions {
    case .notDetermined:
      self.store.requestAccess(to: self.event) {
        (granted: Bool, _: Error?) in
        if granted {
          // request Initialization
          if self.event == .event {
            self.fetchCalendarEvents()
          } else if self.event == .reminder {
            self.fetchReminderEvents()
          }
        } else {
          // throw a popup asking for permissions
          // displayErrorPopup()
        }
      }
      return ("Not Determined", "No Idea")
    case .restricted, .denied:
      return ("Restricted", "Permission toh dena padega meri Jaan")
    case .authorized:
      if self.event == .event {
        self.fetchCalendarEvents()
      } else if self.event == .reminder {
        self.fetchReminderEvents()
      }
      return ("Permitted", "Yay!! Nacho BC")
    default:
      return ("Something", "Something something \\(-|-)/")
    }
  }
  
  private func defaultStartDate() -> Date? {
    NSLog("defaultStartDate Called")
    
    var dateComponent = DateComponents()
    dateComponent.day = -1
    return self.calendar.date(byAdding: dateComponent, to: Date(), wrappingComponents: false)
  }
  
  private func defaultEndDate() -> Date? {
    NSLog("defaultEndDate Called")
    
    var dateComponent = DateComponents()
    dateComponent.year = 1
    return self.calendar.date(byAdding: dateComponent, to: Date(), wrappingComponents: false)
  }
  
  func fetchCalendarEvents(_ startDate: Date? = nil, _ endDate: Date? = nil) {
    NSLog("Fetch Calendar events Called")
    
    let startDate = startDate ?? self.defaultStartDate()
    let endDate = endDate ?? self.defaultEndDate()
    
    var predicate: NSPredicate?
    if let anAgo = startDate, let aNow = endDate {
      predicate = self.store.predicateForEvents(withStart: anAgo, end: aNow, calendars: nil)
    }
    var events: [EKEvent]?
    if let aPredicate = predicate {
      events = self.store.events(matching: aPredicate)
    }
    for i in events ?? [] {
      print(i)
    }
  }
  
  func fetchReminderEvents() {
    NSLog("Fetch Reminders Called")
    
    self.createReminderEvent("Dummy Event 1")
    let predicate: NSPredicate? = self.store.predicateForReminders(in: nil)
    if let apredicate = predicate {
      self.store.fetchReminders(matching: apredicate, completion: { (_ reminders: [Any]?) in
        for reminder: EKReminder? in reminders as? [EKReminder?] ?? [EKReminder?]() {
          print(reminder!)
        }
      })
    }
  }
  
  func createReminderEvent(_ title: String) {
    NSLog("createReminderEvent Called")
    let sampleReminder = EKReminder(eventStore: self.store)
    
    sampleReminder.title = title
    sampleReminder.calendar = self.store.defaultCalendarForNewReminders()
    do {
      try self.store.save(sampleReminder, commit: true)
    } catch {
      NSLog("Unable to create event: Something went wrong")
    }
  }
}
