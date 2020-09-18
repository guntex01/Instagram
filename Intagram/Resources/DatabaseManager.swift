//
//  DatabaseManager.swift
//  Intagram
//
//  Created by guntex01 on 9/15/20.
//  Copyright © 2020 guntex01. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - public
    
    /// check if username and email is available
    /// - parameters
    ///    - email: String representing email
    ///    - username: String represneting username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
   /// Inserts new user data to database
   /// - parameters
   ///    - email: String representing email
   ///    - username: String represneting username
    ///    - completion: Async callback for result if database entry succeded 
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]){ error, _ in
            if error == nil {
                // seccessed
                completion(true)
                return
            }else{
                // failed
                completion(false)
                return
            }
        }
    }
}
