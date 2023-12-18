//
//  LoginViewController.swift
//  Login
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import UIKit
import Home

public class LoginViewController: UIViewController {
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    let projectNameLabel: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoTravelmeit")?.withRenderingMode(.alwaysTemplate))
        if let thirdColor = UIColor(named: "ThirdColor") {
            imageView.tintColor = thirdColor
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
        }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    let loginButton = UIButton(type: .system)
    let createAccountButton = UIButton(type: .system)
    
    let loginViewModel = LoginViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackGroundImage()
        configureLoginButton()
        configureCreateAccountButton()
        setupLayout()
        adjustImageSizes()
        loginViewModel.onLoginSuccess = {[weak self] in
            // Navegar a la vista de Home
            self?.tapNavigateHome()
            print("Navega a Home")
        
            
        }
        loginViewModel.onLoginFailure = { [weak self] errorMessage in
            self?.showAlert(with: "Error", message: errorMessage)
        }
    }
    
    private func configureBackGroundImage() {
        backgroundImage.image = UIImage(named: "PantallaEntrada")
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setupLayout() {
        projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(projectNameLabel)
            
        let verticalStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 15

        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
    
        view.insertSubview(backgroundImage, at: 0)

        NSLayoutConstraint.activate([
            projectNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            projectNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func adjustImageSizes() {
        if let logoImage = UIImage(named: "logoTravelmeit") {
            let logoSize = logoImage.size
            NSLayoutConstraint.activate([
                projectNameLabel.widthAnchor.constraint(equalToConstant: logoSize.width / 1.25),
                projectNameLabel.heightAnchor.constraint(equalToConstant: logoSize.height / 1.25)
            ])
        }
    }


    private func configureLoginButton() {
        loginButton.setTitle("Log In", for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 1
        loginButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        if let thirdColorBorder = UIColor(named: "ThirdColor") {
            loginButton.layer.borderColor = thirdColorBorder.cgColor
        }
        if let thirdColorFont = UIColor(named: "ThirdColor") {
            loginButton.tintColor = thirdColorFont
        }
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard let email = usernameTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", message: "An error occurred during user input.")
            return
        }
        loginViewModel.login(email: email, password: password)
    }
    
    private func configureCreateAccountButton() {
        createAccountButton.setTitle("Create new account", for: .normal)
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.layer.borderWidth = 1
        createAccountButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        if let thirdColorBorder = UIColor(named: "ThirdColor") {
            createAccountButton.layer.borderColor = thirdColorBorder.cgColor
        }
        if let thirdColorFont = UIColor(named: "ThirdColor") {
            createAccountButton.tintColor = thirdColorFont
        }
        createAccountButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createAccountButtonTapped() {

        let createAccountViewController = CreateAccountViewController()
        self.present(createAccountViewController, animated: true, completion: nil)
    }

    
    private func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alertController, animated: true)
    }
    
    @objc func tapNavigateHome() {
        guard let homeViewController = HomeViewBuilder.getFirstView() else { return }
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
