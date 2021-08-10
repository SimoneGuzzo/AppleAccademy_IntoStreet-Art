  //
 //  ContentView.swift
 //  StreetApp
 //
 //  Created by Salvatore Nanni on 27/01/2020.
 //  Copyright © 2020 AppCoda. All rights reserved.
 //

 import SwiftUI
import MapKit
  
 struct ContentView: View {
    @ObservedObject var locationModel = LocationModel()
        
        var userLocation: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: locationModel.userLatitude, longitude: locationModel.userLongitude)
            
        }
    
     var body: some View {
         TabView{
             Pagina1().tabItem{
                Text("Home")
                Image(systemName: "house")
             }.tag(0)

             Favorites().tabItem{
                Text("Bookmarks")
                Image(systemName: "book")
            }.tag(1)
        }
 }
 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
         
     }
    }
  }
 
