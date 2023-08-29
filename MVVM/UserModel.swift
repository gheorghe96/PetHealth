//
//  UserManager.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import Foundation
import FirebaseAuth

class UserModel: ObservableObject {
    static let shared = UserModel()
    
    @Published var user: User? = nil
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if ((user) != nil) {
                self.user = User(uid: user!.uid, email: user?.email ?? "undefined")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (FirebaseAuth.AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(authResult, error)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (FirebaseAuth.AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(authResult, error)
        }
    }
}
