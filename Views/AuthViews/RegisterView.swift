//
//  RegisterView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Create account")
                .font(.title)
                .bold()
            
            TextField("Email", text: self.$email)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).padding(.bottom)
            
            TextField("Password", text: self.$password)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
            
            Button("Register") {
                self.onRegisterPress()
            }
            .padding(.top)
            .buttonStyle(BorderedProminentButtonStyle())
            
        }
    }
    
    func onRegisterPress() {
        UserModel.shared.register(email: self.email, password: self.password) { authResult, error in
            if (error != nil) {
                print(error?.localizedDescription)
                return
            }
            
            print(authResult)
        }
    }
}
