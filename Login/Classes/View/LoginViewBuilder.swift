//
//  LoginViewBuilder.swift
//  Login
//
//  Created by Enrique Alata Vences on 14/12/23.
//

import UIKit

public class LoginViewBuilder {
    public static func getFirstView() -> UIViewController? {
        let moduleBundle = Bundle(for: LoginViewBuilder.self)
        guard let loginViewController = UIStoryboard.init(name: "Login", bundle: moduleBundle).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return nil}
        return loginViewController
    }
}
