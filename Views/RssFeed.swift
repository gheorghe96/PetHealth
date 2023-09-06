//
//  RssFeed.swift
//  pethealth
//
//  Created by Gheorghe Curca on 03.09.2023.
//

import SwiftUI
import FeedKit
import Foundation

struct RssFeed: View {
    var rssUrl: URL
    
    @State private var rssTitle: String = ""
    @State private var rssItems: [RSSFeedItem] = []
    @State private var dateFormatted = DateFormatter()
    
    var body: some View {
        VStack {
            Text(rssTitle)
                .bold()
                .padding(.bottom)
            
            ForEach(rssItems, id: \.title) { item in
                NavigationLink(destination: RssFeedItem(item: item)) {
                    VStack {
                        HStack {
                            Text(item.title ?? "")
                                .bold()
                                .foregroundColor(Color(uiColor: .label))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text(item.pubDate!.toString(dateFormat: "dd MMM yyyy HH:mm"))
                                .font(.system(size: 12))
                                .padding(.top)
                        }
                    }
                }
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding(.horizontal)
        }
        .onAppear {
            fetchRSSFeed()
        }
    }
    
    func fetchRSSFeed() {
        let parser = FeedParser(URL: rssUrl)
        
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                DispatchQueue.main.async {
                    self.rssTitle = feed.rssFeed?.title ?? ""
                    self.rssItems = feed.rssFeed?.items ?? []
                }
            case .failure(let error):
                print("Feed parsing error: \(error)")
            }
        }
    }
}
