//
//  HomeViewController.swift
//  ToDoListApp
//
//  Created by Ramiro Gutierrez on 19/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    private var authenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutActionBtn(_ sender: Any) {
        do {
            try authenticationViewModel.logout()
            // Recorre la pila de navegación para encontrar la instancia adecuada de ViewController
            if let viewControllers = self.navigationController?.viewControllers {
                for viewController in viewControllers {
                    if let viewController = viewController as? ViewController {
                        // Una vez que se encuentra la instancia correcta, retrocede a ella
                        self.navigationController?.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }
        } catch {
            print("Hubo un error al cerrar sesión")
        }
    }
}
