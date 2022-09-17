//
//  HomeRouter.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 07/08/22.
//

import Foundation
import UIKit

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
  
  func presentAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .destructive)
    alertController.addAction(okButton)
    view?.present(alertController, animated: true)
  }
}
