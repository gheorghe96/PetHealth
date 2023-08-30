//
//  PetManager.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class PetManager: ObservableObject {
    static let shared = PetManager()
    
    @Published var pets: [Pet] = []
    
    private let db = Firestore.firestore()
    private let petsCollection = "pets"
    
    private var itemsListener: ListenerRegistration?
    
    init () {
        itemsListener = db.collection(petsCollection)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if let pet = try? diff.document.data(as: Pet.self) {
                        switch diff.type {
                        case .added:
                            DispatchQueue.main.async {
                                self.pets.append(pet)
                            }
                        case .modified:
                            print("pet modified")
                        case .removed:
                            print("pet removed")
                        }
                    } else {
                        print("Error decoding pet data")
                    }
                }
            }
    }
    
    deinit {
        itemsListener?.remove()
        itemsListener = nil
    }
    
    func create(pet: Pet, completion: @escaping (Error?) -> Void) {
        db.collection(petsCollection).addDocument(data: pet.dictionary) { error in
            completion(error)
        }
    }
}
