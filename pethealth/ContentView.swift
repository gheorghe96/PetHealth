//
//  ContentView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userModel = UserModel.shared
    
    var body: some View {
        if (userModel.user != nil) {
            HomeView()
        } else {
            LoginView()
        }
    }
}
