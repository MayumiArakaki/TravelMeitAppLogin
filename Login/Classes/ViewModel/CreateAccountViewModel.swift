//
//  CreateAccountViewModel.swift
//  Login
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import UIKit
import FirebaseAuth

class CreateAccountViewModel {
    
    var onCreateSuccess: (() -> Void)?
    var onCreateFailure: ((String) -> Void)?
    
    func create(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let _ = result, error == nil {
                self?.onCreateSuccess?()
            } else {
                self?.onCreateFailure?(error?.localizedDescription ?? "Se ha producido un error en la creación de usuario")
            }
        }
    }
}
