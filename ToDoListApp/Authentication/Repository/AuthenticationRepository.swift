//
//  AuthenticationRepository.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 18/04/24.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFireBaseDataSource: AuthenticationFirebaseDataSource
    
    init(authenticationFireBaseDataSource: AuthenticationFirebaseDataSource = AuthenticationFirebaseDataSource()) {
        self.authenticationFireBaseDataSource = authenticationFireBaseDataSource
    }
    
    func getCurrentUser() -> User? {
        authenticationFireBaseDataSource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void) {
        authenticationFireBaseDataSource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
    }
    func login(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void) {
        authenticationFireBaseDataSource.login(email: email,
                                               password: password,
                                               completionBlock: completionBlock)
    }
    
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFireBaseDataSource.loginWithFacebook(completionBlock: completionBlock)
    }
    
    func logout() throws {
       try authenticationFireBaseDataSource.logout()
    }
    
}
