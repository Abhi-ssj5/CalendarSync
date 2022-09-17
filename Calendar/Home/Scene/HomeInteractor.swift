//
//  HomeInteractor.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 07/08/22.
//

import Foundation

final class HomeInteractorImplementation: HomeInteractor {
  
  private(set) weak var output: HomeInteractorOutput?
  
  init(output: HomeInteractorOutput) {
    self.output = output
  }
  
  // MARK: - HomeInteractor methods
  
  func handleLogin(result: SignInResponse) {
    switch result {
    case .success(let userData):
      output?.handleLoginSuccess(response: userData)
    case .failure(let error):
      output?.handleLoginFailure(error: error)
    }
  }
  
}
