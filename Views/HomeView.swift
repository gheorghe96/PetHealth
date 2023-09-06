//
//  HomeView.swift
//  pethealth
//
//  Created by Gheorghe Curca on 29.08.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var petsManager = PetManager.shared
    private var storageManager = StorageManager.shared
    
    private var rssUrls: [String] = [
        "https://2pawsupinc.com/feed/",
        "https://www.adogwalksintoabar.com/blog-feed.xml",
        "https://www.aboundpetsupplies.co/feeds/posts/default?alt=rss",
        "https://holisticpetwellness.co/feed/",
        "https://www.petsloo.com/feed/"
    ]
    
    var body: some View {
        VStack {
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
                
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(rssUrls, id: \.hashValue) { url in
                            RssFeed(rssUrl: URL(string: url)!)
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                        }
                    }
                }
            }
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
            
            if (Bool(!pet.image!.isEmpty)) {
                URLImageView(url: URL(string: pet.image ?? "")!)
            } else {
                Image(pet.category)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .frame(width: 250, height: 250)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
