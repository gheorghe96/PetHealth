//
//  FillPetInfo.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI
import PhotosUI

struct FillPetInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var petCategory: String
    @State private var pet: Pet = Pet(category: "Default", name: "Oscar", breed: "Scottish")
    
    @State private var image: UIImage?
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            if (image != nil) {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(20)
                    .frame(height: 200)
            } else {
                Image(petCategory)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(20)
                    .frame(height: 200)
            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                        }
                    }
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
            pet.category = petCategory
        }
        .navigationTitle(petCategory.capitalizedSentence)
    }
    
    func onSavePress() {
            StorageManager.shared.upload(image: image) { (url, error) in
                if (error != nil) {
                    print(error?.localizedDescription)
                    return
                }
                
                pet.image = url?.absoluteString ?? ""
                
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
}
