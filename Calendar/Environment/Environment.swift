//
//  Environment.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import Foundation

struct Environment {

  // MARK: - Private properties

  private struct Constants {
    static let googleClientId: String = "GOOGLE_CLIENT_ID"
  }

  private let bunldeDictionary: [AnyHashable: Any]?

  // MARK: - Init

  init() {
    bunldeDictionary = Bundle.main.infoDictionary
  }

}

// MARK: - EnvironmentInterface

extension Environment: EnvironmentInterface {

  var googleClientId: String? {
    if let clientId = self.bunldeDictionary?[Constants.googleClientId] as? String {
      return clientId
    }
    return nil
  }

}
