//
//  Map.swift
//  StreetApp
//
//  Created by Salvatore Nanni on 27/01/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//



import SwiftUI
import MapKit

class MapCoordinator:NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)

        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: annotation!.coordinate),
                       MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: span)
                   ]
        let placemark = MKPlacemark(coordinate: annotation!.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = annotation!.title!
        mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let annotation = view.annotation
                let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: annotation!.coordinate),
                               MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: span)
                           ]
                let placemark = MKPlacemark(coordinate: annotation!.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = annotation!.title!
                mapItem.openInMaps(launchOptions: options)
    }
}

struct MapView: UIViewRepresentable {
    
    let art: StreetArt
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        let newLocation = MKPointAnnotation()
        newLocation.title = self.art.title
        newLocation.subtitle = self.art.author
        newLocation.coordinate = self.art.coordinates!
        map.addAnnotation(newLocation)
        return map
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
        let coordinate = CLLocationCoordinate2D(
            latitude: self.art.coordinates!.latitude, longitude: self.art.coordinates!.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        view.showsUserLocation = true
        
    }
}
    
