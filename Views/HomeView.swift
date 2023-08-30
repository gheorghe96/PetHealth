//
//  HomeView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var petsManager = PetManager.shared
    
    var body: some View {
        ScrollView {
            HStack {
                Text("My Pets")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: PetCategoryView()) {
                    Image(systemName: "plus")
                }
            }.padding(.horizontal, 35)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(petsManager.pets) { pet in
                        PetCardView(pet: pet)
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Home")
    }
}

struct PetCardView: View {
    var pet: Pet
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(pet.name!)
                        .font(.title3)
                        .bold()

                    Spacer()
                }

                HStack {
                    Text(pet.breed!)
                        .font(.headline)

                    Spacer()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            Image(pet.category)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
                
        }
        .frame(width: 250, height: 250)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
