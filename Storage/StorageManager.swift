//
//  StorageManager.swift
//  pethealth
//
//  Created by Gheorghe Curca on 30.08.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class StorageManager {
    static var shared = StorageManager()
    let storage = Storage.storage()
    
    func upload(image: UIImage?, completion: @escaping (URL?, Error?) -> Void) {
        
        if (image == nil) {
            completion(URL(string: ""), nil)
            return
        }
        
        // Create a storage reference
        let storageRef = storage.reference().child("image\(Int.random(in: 1...10000)).jpg")
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image!.jpegData(compressionQuality: 1)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                storageRef.downloadURL { (url, error) in
                    if (error != nil) {
                        completion(nil, error)
                    }
                    completion(url!, nil)
                }
            }
        }
    }
}
