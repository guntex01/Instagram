//
//  AuthManager.swift
//  Intagram
//
//  Created by guntex01 on 9/15/20.
//  Copyright © 2020 guntex01. All rights reserved.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - check if username is available
         - check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - create account
                 - insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }else{
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                // either uername or email does not exist
                completion(false)
            }
        }
    }
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }else if let username = username {
            // username log in
            print(username)
        }
    }
    
    /// Altempt to log out firebase user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
    }
}
