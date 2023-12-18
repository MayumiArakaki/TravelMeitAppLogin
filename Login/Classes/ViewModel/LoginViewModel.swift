//
//  LoginViewModel.swift
//  Login
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import UIKit
import FirebaseAuth


class LoginViewModel {

    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    var onCreateSuccess: (() -> Void)?
    var onCreateFailure: ((String) -> Void)?

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let _ = result, error == nil {
                self?.onLoginSuccess?()
            } else {
                self?.onLoginFailure?(error?.localizedDescription ?? "Se ha producido un error en el ingreso de credenciales")
            }
        }
    }
}
