//
//  HomePresenter.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 07/08/22.
//

import Foundation

final class HomePresenterImplementation: HomePresenter {
  
  // MAKR: - Private property
  
  private(set) weak var view: HomeView?
  let router: HomeRouter
  
  // MARK: - Public property
  
  var interactor: HomeInteractor!
  
  // MARK: - Init
  
  init(view: HomeView, router: HomeRouter) {
    self.view = view
    self.router = router
  }
  
  // MARK: - HomePresenter methods
  
  func loginButtonTapped() {
    router.presentSignIn(completion: { [weak self] result in
      guard let self = self else {
        return
      }
      self.interactor.handleLogin(result: result)
    })
  }
  
}

// MARK: - HomeInteractorOutput methods

extension HomePresenterImplementation: HomeInteractorOutput {
  
  func handleLoginSuccess() {
    debugPrint("Login Success")
  }
  
  func handleLoginFailure(error: Error) {
    debugPrint(error.localizedDescription)
  }
  
}
