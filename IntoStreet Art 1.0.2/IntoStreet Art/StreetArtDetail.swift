//
//  StreetArtDetail.swift
//  StreetApp
//
//  Created by Salvatore Nanni on 27/01/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI
import MapKit

struct StreetArtDetail: View {
    let art: StreetArt
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var zoomed = false
    @State private var tapped = false
    @State private var scale: CGFloat = 55.0
    
    @State var show: String
    
    

    var body: some View {
        VStack {
            
            VStack (alignment: .leading){
                        
                if !zoomed {
                    List {
                            
                    ZStack {
                                if !zoomed{
                                        
                                        MapView(art: art)
                                            .onTapGesture {
                                            let coordinate = CLLocationCoordinate2D(
                                            latitude: self.art.coordinates!.latitude, longitude: self.art.coordinates!.longitude)
                                            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
     
                                            let options = [
                                                           MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: coordinate),
                                                           MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: span)
                                                       ]
                                            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
                                            let mapItem = MKMapItem(placemark: placemark)
                                            mapItem.name = self.art.title
                                            mapItem.openInMaps(launchOptions: options)
                                       }
                                            
                                            .offset(y: -150)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .aspectRatio(contentMode: .fit).transition(.identity)
                                        .listRowInsets(EdgeInsets())
                                }
                                if !zoomed {
                                    
                                Image(art.image)
                                    
                                    .resizable()
                                    .listRowInsets(EdgeInsets())
                                    .contentShape(Circle())
                                    .aspectRatio(contentMode: zoomed ? .fill : .fit)
                                    .clipShape(Circle()).overlay(
                                
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4))
                                        .shadow(radius: 9)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.3)) {self.zoomed.toggle()
                                                if self.zoomed {self.scale -= 54}
                                                else {self.scale = 55}
                                            }
                                }.offset(y: scale)}
                                
                                
                                
                                
                                
                                Spacer()
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    VStack (alignment: .leading){
                     if !zoomed{
                        Text(art.title)
                            .multilineTextAlignment(.leading).padding(.leading).font(.title).transition(.identity)}
                    if !zoomed{
                        Text("Author: "+art.author)
                            .multilineTextAlignment(.leading).padding(.leading).font(.title).transition(.identity)
                    }}
                    if !zoomed{
                        Text(art.excerpt).padding().transition(.identity)
                    }
                }
                
                
                          
                                    
            
                }}
                .padding(.horizontal, -20)
                .onAppear { UITableView.appearance().separatorStyle = .none } .onDisappear { UITableView.appearance().separatorStyle = .none }
                
                .navigationBarTitle(Text(art.title), displayMode: .inline)
                .navigationBarItems(trailing:
                Button(action: {
                    if !StreetArtModel.shared.testFavorite.contains(self.art) {
                            StreetArtModel.shared.testFavorite.append(self.art)
                            var a = [String]()
                            for art in StreetArtModel.shared.testFavorite {
                                a.append(art.title)
                            }
                        UserDefaults.standard.set(a, forKey: "Tap")
                        self.show = "bookmark.fill"
                    } else {
                        
                        var a = [String]()
                        var index = -1
                        for (i, artF) in StreetArtModel.shared.testFavorite.enumerated() {
                            if artF.title != self.art.title {
                                a.append(artF.title)
                            } else {
                                index = i
                            }
                        }
                        StreetArtModel.shared.testFavorite.remove(at: index)
                        UserDefaults.standard.set(a, forKey: "Tap")
                        self.show = "bookmark"
                    }
                    
                    
                    
                }) {

                    
                    Image(systemName: show).imageScale(.large)
                }
            )
            if zoomed {
                                            ZStack (alignment: .topTrailing) {
                                            
                                                    
                                                Button(action: {
                                                    self.zoomed.toggle()
                                                    if self.zoomed {self.scale -= 54}
                                                    else {self.scale = 55}
                                                    
                                                }) {
                                                    
                                                    Image("xmark.circle.fill")
                                                        
                                                        .resizable().frame(width: 26, height: 26).foregroundColor(Color.gray).padding(.all).opacity(0.7)
                                                            
                                                }
                                                
                                                Image(art.image)
                                                
                                                .resizable()
                                                    .aspectRatio(contentMode: tapped ? .fill : .fit)
                                                .onTapGesture {
                                                
                                                    self.tapped.toggle()
            //
                                                }.frame(minWidth: 0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity)
                                            
                                            
                                            }
                                            }
        }
    }

struct StreetArtDetail_Previews: PreviewProvider {
    static var previews: some View {
        StreetArtDetail(art: StreetArtModel.shared.testArt[0], show: StreetArtModel.shared.isFavorite(StreetArtModel.shared.testArt[0]))
    }
}
}
