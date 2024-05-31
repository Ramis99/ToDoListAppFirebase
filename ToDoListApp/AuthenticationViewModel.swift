//
//  AuthenticationViewModel.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 18/04/24.
//

import Foundation


final class AuthenticationViewModel: ObservableObject {
    private let authenticationRepository: AuthenticationRepository
    @Published var user: User?
    @Published var messageError: String?
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    func createNewUser(email: String, password: String,  completion: @escaping (Bool) -> Void) {
        authenticationRepository.createNewUser(email: email,
                                               password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                completion(true)
            case .failure(let error):
                self?.messageError = error.localizedDescription
                completion(false)
            }
            
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        authenticationRepository.login(email: email,
                                       password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                completion(true)
            case .failure(let error):
                self?.messageError = error.localizedDescription
                completion(false)
            }
            
        }
    }
    
    func loginWithFacebook(completion: @escaping (Bool) -> Void) {
        authenticationRepository.loginWithFacebook { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                completion(true)
            case .failure(let error):
                self?.messageError = error.localizedDescription
                completion(false)
            }
            
        }
    }
    
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func logout() throws {
        do {
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print("error logout")
        }
    }
}
