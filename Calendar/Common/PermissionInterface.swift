//
//  PermissionInterface.swift
//  Calendar
//
//  Created by Ankush Gupta on 07/08/22.
//

import EventKit

protocol PermissionInterface {
  var store: EKEventStore { get }
  var event: EKEntityType { get set }

  func requestPermissions() -> (title: String, message: String)
}
