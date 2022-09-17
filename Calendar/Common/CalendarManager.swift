//
//  CalendarManager.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 17/09/22.
//

import Foundation
import GoogleAPIClientForREST

protocol CalendarManager {
  func fetchCalendars()
}

final class GoogleCalendarManager: CalendarManager {
  
  let calendarService: GTLRCalendarService
  
  init() {
    self.calendarService = GTLRCalendarService()
  }
  
  func fetchCalendars() {
    calendarService.executeQuery(getQuery()) { (ticket, respone, error) in
      
    }
  }
  
  private func getQuery() -> GTLRQueryProtocol {
    return GTLRCalendarQuery_CalendarListList.query()
  }
  
}
