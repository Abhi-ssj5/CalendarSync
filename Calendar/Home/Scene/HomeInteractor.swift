//
//  HomeInteractor.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 07/08/22.
//

import Foundation

final class HomeInteractorImplementation: HomeInteractor {

  private(set) weak var output: HomeInteractorOutput?
  private let calendarManager: CalendarManager

  init(output: HomeInteractorOutput,
       calendarManager: CalendarManager) {
    self.output = output
    self.calendarManager = calendarManager
  }

  // MARK: - HomeInteractor methods

  func handleLogin(result: SignInResponse) {
    switch result {
    case .success:
      output?.handleLoginSuccess()
    case .failure(let error):
      output?.handleLoginFailure(error: error)
    }
  }

  func fetchCalendars() {
    calendarManager.fetchCalendars()
  }
  
}
