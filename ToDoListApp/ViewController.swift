//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 17/04/24.
//

import UIKit
import Firebase
import FacebookLogin

class ViewController: UIViewController {
    
   private var authenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authenticateUser()
//        Analytics.logEvent("evento_personalizado", parameters: [
//            "nombre": "valor"
//        ])
    }
    
    private func authenticateUser() {
        if let user = authenticationViewModel.user {
            print("usuario logeado", user.email)
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("usuario sin logear")
        }
    }
    
    private func handleUserCreationResult(success: Bool) {
        if success {
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Falló la creación del usuario, manejar el error si es necesario
            print("Error al crear el usuario:", authenticationViewModel.messageError ?? "Mensaje de error no disponible")
        }
    }
    @IBAction func loginActionBtn(_ sender: Any) {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginWithFacebookActionBtn(_ sender: Any) {
        authenticationViewModel.loginWithFacebook() { [weak self] success in
            DispatchQueue.main.async {
                self?.handleUserCreationResult(success: success)
            }
        }
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



