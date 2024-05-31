//
//  AuthenticationFirebaseDataSource.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 18/04/24.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFirebaseDataSource {
  private let facebookAuthentication = FacebookAuthentication()
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {AuthDataResult, error in
            if let error = error {
                print("Ha ocurrido un error al crear el usuario", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            
            let email = AuthDataResult?.user.email ?? "No email"
            print("Nuevo usuario creado con la informacion", email)
            completionBlock(.success(.init(email: email)))
        }
        
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {AuthDataResult, error in
            if let error = error {
                print("Ha ocurrido un error al iniciar sesion", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            
            let email = AuthDataResult?.user.email ?? "No email"
            print("Sesion iniciada con el correo", email)
            completionBlock(.success(.init(email: email)))
        }
        
    }
    
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { AuthDataResult, error in
                    if let error = error {
                        print("error creating new user\(error.localizedDescription)")
                        completionBlock(.failure(error))
                    }
                    let email = AuthDataResult?.user.email ?? "No email"
                    print("new user created with email \(email)")
                    completionBlock(.success(.init(email: email)))
                }
            case .failure(let error):
                print("error  signin with facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
