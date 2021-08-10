//
//  Favorites.swift
//  StreetApp
//
//  Created by Vincenzo on 30/01/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct Favorites: View {
    @ObservedObject var favo = StreetArtModel.shared
    var body: some View {
        NavigationView {
            List {
                            ForEach(favo.testFavorite, id: \.self) { item in
     
                            ZStack {
                                NavigationLink(destination: StreetArtDetail(art: item, show: StreetArtModel.shared.isFavorite(item))) {
                                EmptyView() }
                                VStack (alignment: .center)
                                {
                                    Image(item.image)
                                        .resizable().aspectRatio(contentMode: .fit).cornerRadius(7)
                                    
                                    Text(item.title)
                
                                    HStack(spacing: 3) {
                                        Text(String(format: "Distance %.2f Km", item.distances ))
                                       Spacer()
                                       
                                        HStack {
                                           Text("Rating")
                                            ForEach(1...(item.rating), id: \.self) { _ in
                                                Image(systemName: "star.fill")
                                                    .font(.caption)
                                                    .foregroundColor(.yellow)
                                            }
                                            if item.rating < 5
                                            {
                                                ForEach(1...5-(item.rating), id: \.self) { _ in
                                                Image(systemName: "star")
                                                    .font(.caption)
                                                    .foregroundColor(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                                }
                                }.onDelete(perform: {
                                    index in
                                    self.favo.testFavorite.remove(atOffsets: index)
                                    var a = [String]()
                                    for art in StreetArtModel.shared.testFavorite {
                                        a.append(art.title)
                                    }
                                    UserDefaults.standard.set(a, forKey: "Tap")
                                    
                                    
                                })
                    
                    }.onAppear { UITableView.appearance().separatorStyle = .singleLine } .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
            .navigationBarTitle(Text("Your Bookmarks"))
        }

    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
