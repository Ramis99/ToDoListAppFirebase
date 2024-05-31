//
//  RegisterViewController.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 18/04/24.
//

import UIKit
import Firebase

class RegisterViewController: ViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    private var authenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func registerActionBtn(_ sender: Any) {
        authenticationViewModel.createNewUser(email: txtEmail.text ?? ""  ,password: txtPassword.text ?? "") { [weak self] success in
            DispatchQueue.main.async {
                self?.handleUserCreationResult(success: success)
            }
        }
    }
}
