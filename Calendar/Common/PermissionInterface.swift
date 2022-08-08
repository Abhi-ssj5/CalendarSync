//
//  PermissionInterface.swift
//  Calendar
//
//  Created by Ankush Gupta on 07/08/22.
//

import EventKit

protocol PermissionInterface {
  var store: EKEventStore { get }
  func requestPermissions(_ event: EKEntityType) -> Void
}
