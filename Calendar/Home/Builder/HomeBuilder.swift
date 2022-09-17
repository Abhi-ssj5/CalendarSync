//
//  HomeBuilder.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import UIKit

struct HomeBuilder: HomeBuilderInterface {

  static func build() -> HomeView {
    let view: HomeView = HomeViewController()

    let router: HomeRouter = HomeRouterImplementation(view: view)
    let presenter = HomePresenterImplementation(view: view,
                                                router: router)
    let calendarManager: CalendarManager = GoogleCalendarManager()
    let interactor: HomeInteractor = HomeInteractorImplementation(output: presenter,
                                                                  calendarManager: calendarManager)

    presenter.interactor = interactor
    view.presenter = presenter

    return view
  }

}
