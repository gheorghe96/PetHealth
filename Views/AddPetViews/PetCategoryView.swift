//
//  PetCategoryView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct PetCategoryView: View {
    var body: some View {
        ScrollView {
            HStack {
                NavigationLink(destination: FillPetInfo(petCategory: "cat")) {
                    PetCategoryCardView(imageName: "cat", text: "Cat")
                }
                
                Spacer(minLength: 10)
                
                NavigationLink(destination: FillPetInfo(petCategory: "dog")) {
                    PetCategoryCardView(imageName: "dog", text: "Dog")
                }
            }
            .padding(.horizontal)
            
            HStack {
                NavigationLink(destination: FillPetInfo(petCategory: "bird")) {
                    PetCategoryCardView(imageName: "bird", text: "Bird")
                }
                
                Spacer(minLength: 10)
                
                NavigationLink(destination: FillPetInfo(petCategory: "rabbit")) {
                    PetCategoryCardView(imageName: "rabbit", text: "Rabbit")
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Category")
    }
}

struct PetCategoryCardView: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(20)
            
            Text(text)
                .font(.headline)
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
