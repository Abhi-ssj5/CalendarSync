//
//  HomeProtocols.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import UIKit

protocol HomeBuilderInterface {
  static func build() -> HomeView
}

protocol HomeView where Self: UIViewController { }
