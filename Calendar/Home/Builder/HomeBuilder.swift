//
//  HomeBuilder.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import UIKit

struct HomeBuilder: HomeBuilderInterface {
  
  static func build() -> HomeView {
    return HomeViewController()
  }
  
}
