//
//  ImageLoader.swift
//  pethealth
//
//  Created by Gheorghe Curca on 30.08.2023.
//

import Foundation
import SwiftUI
import Combine

struct URLImageView: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
        } else {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
