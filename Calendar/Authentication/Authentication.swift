//
//  Authentication.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import Foundation
import GoogleSignIn

struct Authentication: AuthenticationInterface {

  // MARK: - Public property

  static let shared: AuthenticationInterface = {
    return Authentication(environment: Environment())
  }()

  // MARK: - Private properties

  private let signInConfig: GIDConfiguration?

  // MARK: - Init

  private init(environment: EnvironmentInterface) {
    if let cliendId = environment.googleClientId {
      self.signInConfig = GIDConfiguration(clientID: cliendId)
    } else {
      self.signInConfig = nil
    }
  }

  // MARK: - AuthenticationInterface methods

  func isCallbackUrlHandled(_ url: URL) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }

  func signIn(viewController: UIViewController,
              completion: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
    guard let signInConfig = signInConfig else {
      return
    }
    GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: viewController) { (user, error) in
      if let error = error {
        completion(.failure(error))
      } else if let user = user {
        completion(.success(user))
      } else {
        completion(.failure(CustomError.unknown))
      }
    }
  }
}
