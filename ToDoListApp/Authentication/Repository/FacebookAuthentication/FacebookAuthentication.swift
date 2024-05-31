//
//  FacebookAuthentication.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 19/04/24.
//

import Foundation
import FacebookLogin

final class FacebookAuthentication {
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil) { LoginManagerLoginResult, error in
            if let error = error {
                print("Error Login Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let token = LoginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "Empty Token"))
            
        }
    
    }
}
