//
//  HomeViewController.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import UIKit

final class HomeViewController: UIViewController, HomeView {
  
  // MARK: - IBOutlet
  
  @IBOutlet private weak var loginButton: UIButton!
  
  // MARK: - Public property
  
  var presenter: HomePresenter!
  
  // MARK: - LifeCycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Button Actions
  
  @IBAction private func loginButtonTapped(_ sender: UIButton) {
    presenter.loginButtonTapped()
  }
  
}
