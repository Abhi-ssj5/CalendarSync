//
//  AuthenticationInterface.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import GoogleSignIn

typealias SignInResponse = Result<GIDGoogleUser, Error>
typealias SignInResponeBlock = (SignInResponse) -> Void

protocol AuthenticationInterface {
  
  func isCallbackUrlHandled(_ url: URL) -> Bool
  func signIn(viewController: UIViewController,
              completion: @escaping SignInResponeBlock)
  
}
