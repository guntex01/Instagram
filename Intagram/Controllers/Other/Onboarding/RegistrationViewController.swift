//
//  RegistrationViewController.swift
//  Intagram
//
//  Created by guntex01 on 9/15/20.
//  Copyright © 2020 guntex01. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameFiled: UITextField = {
        let field = UITextField()
        field.placeholder = "username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameFiled.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(usernameFiled)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameFiled.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y:usernameFiled.bottom + 10 , width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40 , height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
    }
    
    @objc private func didTapRegister() {
        emailField.resignFirstResponder()
        usernameFiled.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty,
            let username = usernameFiled.text, !username.isEmpty
        else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                }else{
                    // failed
                }
            }
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameFiled {
            emailField.becomeFirstResponder()
        }else if textField == emailField {
            passwordField.becomeFirstResponder()
        }else{
            didTapRegister()
        }
        return true
    }
}
