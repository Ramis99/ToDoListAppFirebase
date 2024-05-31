//
//  LoginViewController.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 18/04/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    private var authenticationViewModel = AuthenticationViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func handleLoginResult(success: Bool) {
        if success {
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Falló la creación del usuario, manejar el error si es necesario
            print("Error al crear el usuario:", authenticationViewModel.messageError ?? "Mensaje de error no disponible")
        }
    }

    @IBAction func loginActionBtn(_ sender: Any) {
        authenticationViewModel.login(email: txtEmail.text ?? "", password: txtPassword.text ?? "") { success in
            DispatchQueue.main.async {
                self.handleLoginResult(success: success)
            }
        }
    }
    

}
