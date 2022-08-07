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

protocol HomeView where Self: UIViewController {
  var presenter: HomePresenter! { get set }
}

protocol HomePresenter: AnyObject {
  var view: HomeView? { get }
  var router: HomeRouter { get }
  var interactor: HomeInteractor! { get }
  
  func loginButtonTapped()
  
}

protocol HomeInteractor: AnyObject {
  var output: HomeInteractorOutput? { get }
  
  func handleLogin(result: SignInResponse)
}

protocol HomeInteractorOutput: AnyObject {
  func handleLoginSuccess()
  func handleLoginFailure(error: Error)
}

protocol HomeRouter: AnyObject {
  var view: HomeView? { get }
  
  func presentSignIn(completion: @escaping SignInResponeBlock)
}
