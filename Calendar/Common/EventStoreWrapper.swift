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

  func handleFetchEvent() {
    if self.event == .event {
      self.fetchCalendarEvents()
    } else if self.event == .reminder {
      self.fetchReminderEvents()
    }
  }

  func handleCreateEvent() {
    if self.event == .event {
      self.createCalendarEvent("Test Calendar Event")
    } else if self.event == .reminder {
      self.createReminderEvent("Test Reminder Event")
    }
  }

  func requestPermissions() -> (title: String, message: String) {
    let currentPermissions = EKEventStore.authorizationStatus(for: self.event)
    switch currentPermissions {
    case .notDetermined:
      self.store.requestAccess(to: self.event) { (granted: Bool, _: Error?) in
        if granted {
          self.handleFetchEvent()
          self.handleCreateEvent()
        } else {
          // throw a popup asking for permissions
          // displayErrorPopup()
        }
      }
      return ("Not Determined", "No Idea")
    case .restricted, .denied:
      return ("Restricted", "Permission toh dena padega meri Jaan")
    case .authorized:
      self.handleFetchEvent()
      self.handleCreateEvent()
      return ("Permitted", "Yay!! Nacho BC")
    default:
      return ("Something", "Something something \\(-|-)/")
    }
  }

  private func defaultStartDate() -> Date? {
    print("defaultStartDate Called")

    var dateComponent = DateComponents()
    dateComponent.day = -1
    return self.calendar.date(byAdding: dateComponent, to: Date(), wrappingComponents: false)
  }

  private func defaultEndDate() -> Date? {
    print("defaultEndDate Called")

    var dateComponent = DateComponents()
    dateComponent.month = 1
    return self.calendar.date(byAdding: dateComponent, to: Date(), wrappingComponents: false)
  }

  func fetchCalendarEvents(_ startDate: Date? = nil, _ endDate: Date? = nil, completed: Bool = false) {
    print("Fetch Calendar events Called")

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
    dump(events)
  }

  func fetchReminderEvents(completed: Bool = false) {
    print("Fetch Reminders Called")

    let predicate: NSPredicate? = self.store.predicateForReminders(in: nil)
    if let apredicate = predicate {
      self.store.fetchReminders(matching: apredicate, completion: { (_ reminders: [Any]?) in
        for reminder: EKReminder? in reminders as? [EKReminder?] ?? [EKReminder?]() {
          dump(reminder!, name: "Reminder found")
        }
      })
    }
  }

  func createReminderEvent(_ title: String) {
    print("createReminderEvent Called")
    var reminder: EKReminder = EKReminder(eventStore: self.store)
    // This might be updated later to a custom calendar created by our Application
    reminder.calendar = self.store.defaultCalendarForNewReminders()
    // Fill the data of the reminder based on the google reminder data
    reminder = self.fillGoogleReminderData(reminder, title)

    do {
      try self.store.save(reminder, commit: true)
      dump(reminder, name: "Success Reminder")
    } catch {
      print("Reminder Creation Failed: \(error)")
      dump(reminder, name: "Failed Reminder")
    }
  }

  func fillGoogleReminderData(_ reminder: EKReminder, _ title: String) -> EKReminder {
    print("createGoogleReminderEvent Called")

    let newReminder = reminder
    // Data: To be replaced with google calendar reminder
    newReminder.title = title

    return newReminder
  }

  func createCalendarEvent(_ title: String) {
    print("createCalendarEvent Called")
    var event: EKEvent = EKEvent(eventStore: self.store)
    // This might be updated later to a custom calendar created by our Application
    event.calendar = self.store.defaultCalendarForNewEvents
    // Fill the data of the event based on the calendar event Data
    event = self.fillGoogleEventData(event, title)

    do {
      try self.store.save(event, span: .thisEvent, commit: true)
      dump(event, name: "Success Event")
    } catch {
      print("Event create failed: \(error)")
      dump(event, name: "Failed Event")
    }
  }

  func fillGoogleEventData(_ event: EKEvent, _ title: String) -> EKEvent {
    print("createGoogleCalendarEvent Called")

    let newEvent = event
    // Data: To be replaced with Google Calendar structure.
    newEvent.title = title
    newEvent.notes = "Programatically Created new Event"
    newEvent.startDate = Date()
    newEvent.endDate = Date(timeIntervalSinceNow: 3600)

    return newEvent
  }
}
