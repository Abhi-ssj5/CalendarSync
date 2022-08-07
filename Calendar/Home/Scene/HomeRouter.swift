//
//  HomeRouter.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 07/08/22.
//

import Foundation

final class HomeRouterImplementation: HomeRouter {
  
  private(set) weak var view: HomeView?
  
  init(view: HomeView) {
    self.view = view
  }
  
  // MARK: - HomeRouter methods
  
  func presentSignIn(completion: @escaping SignInResponeBlock) {
    guard let viewController = view else {
      return
    }
    Authentication.shared.signIn(viewController: viewController, completion: completion)
  }
}
