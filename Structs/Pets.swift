//
//  Pets.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Pet: Identifiable, Codable {
    @DocumentID var id: String?
    var category: String
    var name: String?
    var breed: String?
    var age: String?
    var weight: String?
    var height: String?
    var color: String?
    
    var dictionary: [String: Any] {
        return [
            "category": category,
            "name": name ?? "",
            "breed": breed ?? "",
            "age": age ?? "",
            "weight": weight ?? "",
            "height": height ?? "",
            "color": color ?? ""
        ]
    }
}
