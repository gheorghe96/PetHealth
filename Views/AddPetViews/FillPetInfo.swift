//
//  FillPetInfo.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct FillPetInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var petCategory: String
    @State private var pet: Pet = Pet(category: "Default")
    
    @State private var image: String?
    
    var body: some View {
        VStack {
            
            Image(image ?? petCategory)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(20)
                .frame(height: 200)
            
            Button("Attach image") {
                
            }
            
            Form {
                Section("Pet Info") {
                    TextField("Name", text: $pet.name.toUnwrapped(defaultValue: ""))
                    TextField("Breed", text: $pet.breed.toUnwrapped(defaultValue: ""))
                }
                
                Section("Specifications") {
                    TextField("Age", text: $pet.age.toUnwrapped(defaultValue: ""))
                    TextField("Weight", text: $pet.weight.toUnwrapped(defaultValue: ""))
                    TextField("Height", text: $pet.height.toUnwrapped(defaultValue: ""))
                    TextField("Color", text: $pet.color.toUnwrapped(defaultValue: ""))
                }
            }
            
            Button("Save") {
                onSavePress()
            }
        }
        .onAppear {
            pet = Pet(category: petCategory)
        }
        .navigationTitle(petCategory.capitalizedSentence)
    }
    
    func onSavePress() {
        PetManager.shared.create(pet: pet) { error in
            if (error != nil) {
                print(error!)
                return
            }
            
            print("New pet added")
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
