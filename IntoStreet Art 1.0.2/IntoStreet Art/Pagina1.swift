//
//  Pagina1.swift
//  StreetApp
//
//  Created by Vincenzo on 27/01/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct Pagina1: View {
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @ObservedObject var art = StreetArtModel.shared
    
    @ObservedObject var locationModel = LocationModel()
    @State var present: Int = 1
    @State var set: Int = 3
    
    var userLocation: CLLocationCoordinate2D {
        let l = CLLocationCoordinate2D(latitude: locationModel.userLatitude, longitude: locationModel.userLongitude)
        StreetArtModel.shared.computeDistance(userLocation: l)
        return l
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                            StreetArtModel.shared.testSearch.removeAll()
                            if self.present == 0 {
                                self.set = 0
                                StreetArtModel.shared.testArt.forEach{
                                  
                                    if
                                        $0.author.lowercased().contains(self.searchText.lowercased()) || self.searchText.lowercased().contains($0.author.lowercased()){
                                        StreetArtModel.shared.testSearch.append($0)
                                    }
                                }
                            }
                            if self.present == 1 {
                                self.set = 1
                                StreetArtModel.shared.testArt.forEach{
                                    if $0.city.lowercased().contains(self.searchText.lowercased()) || self.searchText.lowercased().contains($0.city.lowercased()){
                                        StreetArtModel.shared.testSearch.append($0)
                                    }
                                }
                            }
                            if self.present == 2 {
                                self.set = 2
                                StreetArtModel.shared.testArt.forEach{
                                    if $0.title.lowercased().contains(self.searchText.lowercased()) || self.searchText.lowercased().contains($0.title.lowercased()) {
                                        StreetArtModel.shared.testSearch.append($0)
                                    }
                                }
                            }
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            self.set = 3
                            StreetArtModel.shared.testSearch.removeAll()
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                if  self.showCancelButton == true {
                    Picker(selection: self.$present, label: Text("")) {
                        
                        Text("Author").tag(0)
                        
                        Text("City").tag(1)
                        
                        Text("Title").tag(2)
                        
                    }.pickerStyle(SegmentedPickerStyle()).padding(.all)
                }
                if self.set == 3 {
                    
                    List(art.testArt, id: \.self) { item in
                       
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
                   }.onAppear { UITableView.appearance().separatorStyle = .none } .onDisappear { UITableView.appearance().separatorStyle = .none }
                        
                        .navigationBarTitle(Text("Find Street Art"))
                    
                }
                if self.set != 3 {
                    
                    List(art.testSearch, id: \.self) { item in
                        
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
                        }
                    .navigationBarTitle(Text("Find Street Art"))
                    
                    
                }
                
            }.animation(.easeInOut(duration: 0.3 ))
        }
    }
    
}

struct Pagina1_Previews: PreviewProvider {
    static var previews: some View {
        Pagina1()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}



