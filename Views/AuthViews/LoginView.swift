//
//  LoginView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login to account")
                .font(.title)
                .bold()
            
            TextField("Email", text: self.$email)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).padding(.bottom)
            
            TextField("Password", text: self.$password)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
            
            HStack {
                Text("Does not have account?")
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                }
            }
            .padding(.top)
            
            Button("Login") {
                self.onLoginPress()
            }
            .padding(.top)
            .buttonStyle(BorderedProminentButtonStyle())
            
        }
    }
    
    func onLoginPress() {
        UserModel.shared.login(email: self.email, password: self.password) { authResult, error in
            if (error != nil) {
                print(error?.localizedDescription)
            }
        }
    }
}
