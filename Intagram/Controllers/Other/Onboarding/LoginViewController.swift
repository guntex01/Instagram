//
//  LoginViewController.swift
//  Intagram
//
//  Created by guntex01 on 9/15/20.
//  Copyright © 2020 guntex01. All rights reserved.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailFiled: UITextField = {
        let field = UITextField()
        field.placeholder = "username or Email..."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Servicd", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let heardView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(backgroundImageView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        usernameEmailFiled.delegate = self
        passwordField.delegate = self
        
        addSubviews()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // assign frames
        
        heardView.frame = CGRect(x: 0,
                                 y: 0.0,
                                 width: view.width,
                                 height: view.height/3.0
        )
        
        usernameEmailFiled.frame = CGRect(x: 25,
                                          y: heardView.bottom + 40,
                                          width: view.width - 50,
                                          height: 52.0
        )
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailFiled.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0
        )
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0
        )
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52.0
        )
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                     width: view.width - 20,
                                     height: 50)
        
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard heardView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = heardView.subviews.first else {
            return
        }
        backgroundView.frame = heardView.bounds
        
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "instagram"))
        heardView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: heardView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: heardView.width/2.0,
                                 height: heardView.height - view.safeAreaInsets.top)
    }
    
    private func addSubviews(){
        view.addSubview(usernameEmailFiled)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(heardView)
    }
    
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailFiled.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailFiled.text, !usernameEmail.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
        }
        
        var email: String?
        var username: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        }else {
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username,email: email,password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                }else{
                    // error occurred
                    let alert = UIAlertController(title: "Log In Error",
                                                  message: "we were unable to log you in.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated:  true)
                }
            }
            
        }
    }
    
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/478745558852511/?helpref=hc_fnav") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField ==  usernameEmailFiled {
            passwordField.becomeFirstResponder()
        }else if textField ==  passwordField {
            didTapLoginButton()
        }
        return true
    }
}
