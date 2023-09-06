//
//  RssFeedItem.swift
//  pethealth
//
//  Created by Gheorghe Curca on 03.09.2023.
//

import SwiftUI
import FeedKit

struct RssFeedItem: View {
    var item: RSSFeedItem
    
    var body: some View {
        ScrollView {
            VStack {
                Text(item.title ?? "Title")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text(item.description ?? "Description")
                    .padding(.top)
                
                Text(item.content?.contentEncoded ?? "No content")
            }
            .padding(.horizontal)
        }
        .navigationTitle("Post")
    }
}
