//
//  StreetArt.swift
//  StreetApp
//
//  Created by Salvatore Nanni on 27/01/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import MapKit
import Foundation

struct StreetArt: Identifiable, Hashable {
    
    static func == (lhs: StreetArt, rhs: StreetArt) -> Bool {
        return lhs.id.uuidString == rhs.id.uuidString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
    }
    
    var id = UUID()
    var title: String
    var author: String
    var rating: Int
    var excerpt: String
    var image: String
    var city: String
    var coordinates: CLLocationCoordinate2D?

    var distances: Double = 0

}


class StreetArtModel: ObservableObject {
    static let shared = StreetArtModel()
    
    
    
    @Published var testArt = [
        StreetArt(title: "San Gennaro in Forcella", author: "Jorit", rating: 5, excerpt: "The artwork represents San Gennaro, patron saint of Naples. The author, Jorit, based the saint representation on the face of one of his friends, a construction worker. Initially the work was received with criticism, but it has found his right place in the heart of the city. The mural was also featured in the Italian cult tv series 'Gomorra'.", image: "SGennaro", city: "Forcella", coordinates: CLLocationCoordinate2D(latitude: 40.850127, longitude: 14.260659)),
        
        StreetArt(title: "Maradona in San Giovanni", author: "Jorit", rating: 5, excerpt: "Maradona, one of the most beloved personalities of the city, is represented as an human god in this mural by Jorit. The mural takes up a whole building and is actually visible from kilometers away. As a soccer player, Maradona leaded the Naples’ soccer team to two national titles, so the consideration of being a God (in playing soccer)", image: "mar", city: "San Giovanni",coordinates: CLLocationCoordinate2D(latitude: 40.833594, longitude: 14.309385)),
        
        StreetArt(title: "Ael in Ponticelli", author: "Jorit", rating: 4, excerpt: "The aim of this artwork is to commemorate the day for the Gypsy integration and it features the portrait of a gypsy girl. The importance of this work lies in the role of education in the integration process. The girl lies on books, the only instruments able to get her away from a troubled and harsh surrounding.", image: "Ael", city: "Ponticelli", coordinates: CLLocationCoordinate2D(latitude: 40.861232, longitude: 14.334828)),
        
        StreetArt(title: "Madonna with a gun", author: "Banksy", rating: 4, excerpt: "It is one of the most famous artworks in the city of Naples. It was created by the English writer Banksy, with the aim of representing the close relationship between religion and criminality in Naples. For its high sentimental value it is now protected by a display case, funded by a local business.", image: "3", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.851567, longitude: 14.258882)),
        
        StreetArt(title: "OPG mural", author: "BLU", rating: 5, excerpt: "Created on an unused psychiatric hospital, it represents tree giant figures: the first and biggest is a green man dressed as a prisoner in the act of ripping off his shirt and his ‘identity’ with it. The second has eyes as white as his straitjacket. Behind them follows a smaller figure of a policeman. Needless to say that the artwork represents the atrocities that used to happen in that hospital.", image: "1", city: "Arenella", coordinates: CLLocationCoordinate2D(latitude: 40.853291, longitude: 14.245119)),
        
        StreetArt(title: "San Gennaro and Caravaggio", author: "Roxy in the box", rating: 4, excerpt: "The artwork represents the two figures of San Gennaro patron saint of Naples reading ‘Il Sole 24ore’, a local newspaper, and the painter Caravaggio reading a copy of the ‘New York Times’. The mural is part of a project that aims to encourage people to go visit museums and discover arts, making them feel closer to famous artists and their masterpieces.", image: "24ore", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.852280, longitude: 14.260141)),
        
        StreetArt(title: "Luce", author: "Tono Cruz", rating: 5, excerpt: "It is one of Tono Cruz’s works in Naples. It is literally called Light (in Italian ‘Luce’) for the extreme bright colours used to represent the faces of young members of the local community. With its light it symbolises the hope for a better future for the inhabitants.", image: "Pizzeria Oliva", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.859211, longitude: 14.249274)),
        
        StreetArt(title: "Maradona in Quartieri Spagnoli", author: "Salvatore Iodice", rating: 5, excerpt: "It represents Maradona, one of the most beloved personalities of the city. As a soccer player Maradona leaded the Naples’ soccer team to two national titles in the seasons 1986-1987 and 1989-1990. This made him part of the Neapolitan history from now to eternity, just like this artwork dedicated to him.", image: "6", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.841467, longitude: 14.245004)),
        
        StreetArt(title: "La Pudicizia", author: "Francesco Bosoletti", rating: 5, excerpt: "The artwork, that takes up the whole facade of a building, represents the sculpture of ‘La Pudicizia’: an artwork on display in the Sansevero chapel. The mural gives an opportunity to the city inhabitants to admire one of its greatest artistic pieces.", image: "7", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.841467, longitude: 14.245004)),
        
        StreetArt(title: "Stonewall", author: "Knet", rating: 4, excerpt: "This artwork, located on the door of the headquarters of the Arcigay (a nonprofit organisation that works towards the equality of genders), features two muscular legs (possibly of a man) ending on high heels. The emblematic title refers to the violent confrontations between homosexual activists and police man in the city of New York in 1969.", image: "8", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.847328, longitude: 14.255107)),
        
        StreetArt(title: "Totò in Vico Figurari", author: "Tvboy", rating: 4, excerpt: "It was elected one of the greatest street art works in Naples. It represents Totò, one of the most beloved Italian actors and play writers. With his movies he was able to recreate the real Naples, filling dramatic moments with a bittersweet comedy.  He is pictured as a street artist in a way to represent the close relationship between the ideals of the play writer and the ones of the street artists.", image: "toto 3",
            city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.848971, longitude: 14.258443)),
        
        StreetArt(title: "Ricordo di Mattia Fagnoni", author: "David Vecchiato", rating: 5, excerpt: "In the streets of the ‘Quartieri Spagnoli’, near the Pignasecca market, lies the street art dedicated to Mattia, a child who died only seven years old, victim of a degenerative illness called Sandhoff, a very rare disease. This work was funded by the municipality of Naples and many associations that raise funds for rare diseases like the Sandhoff.", image: "21", city: "Montesanto", coordinates: CLLocationCoordinate2D(latitude: 40.846468, longitude: 14.247544)),
        
        StreetArt(title: "Eduardo", author: "Jorit", rating: 4, excerpt: "Painted on the doors of the San Fernandino theatre, this mural represent one of the greatest actors and play writers in the history of Naples, Eduardo De Filippo. The artwork is a tribute to the great figure, painted in three of his most famous characters. ", image: "11", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.857131, longitude: 14.263205)),
        
        StreetArt(title: "Vandalized Pasolini", author: "Ernest Pignon-Ernest", rating: 4, excerpt: "The artwork is dedicated to the writer Pasolini. Pasolini carries himself, almost asking the people watching “What have you done to me”. The mural was actually vandalized. The stencil used was ripped off and it was never repaired.", image: "ernest", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.847088, longitude: 14.252692)),
        
        StreetArt(title: "La chiesa decorata", author: "Tono Cruz e Mono Gonzalez", rating: 4, excerpt: "The mural takes over the whole facade of the ‘Santissima Maria del Carmine’ Church. The artist aim was to give a new face to the church, that was left in a state of abandonment and with that try to lift up the hearts of the inhabitants.", image: "14", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.846883, longitude: 14.267525)),
        
        StreetArt(title: "Fidel in Mezzocannone", author: "Tono Cruz e Mono Gonzalez", rating: 4, excerpt: "It is a representation of the revolutionary figure of Fidel Castro. He aimed to free cuba from the totalitarian leadership of Fulgencio Batista. The mural, on the facade of  ’Mezzocannone Occupato’ building is a tribute created on the day after Castro’s death.", image: "fidel", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.846617, longitude: 14.256083)),
        
        StreetArt(title: "I baci di Adriana", author: "Adriana Caccioppoli", rating: 3, excerpt: "Street artist Adriana Caccioppoli creates stencils that she puts on walls of periferic streets. Her aim is to create a sense of wonder for the passer-by. In this series of mural she represents moments of love on the cold streets", image: "16", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.849538, longitude: 14.252494)),
        
        StreetArt(title: "Kobe Bryant", author: "Jorit", rating: 4, excerpt: "It is a tribute to Kobe Bryant, ex NBA star recently passed away in an accident. Created by the street artist Jorit, the mural represents the close relationship between Kobe and Italy since the basket player was playing in Italian teams, before getting picked up for NBA.", image: "kobe 4", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.8558571, longitude: 14.226911)),
        
        StreetArt(title: "Pino Daniele", author: "Tvboy", rating: 4, excerpt: "It is a tribute to the singer and song writer Pino Daniele, one of the most beloved figures in Naples. He is painted as an angel with an halo on his head since he recently passed away.", image: "38", city: "Napoli", coordinates: CLLocationCoordinate2D(latitude: 40.850602, longitude: 14.259431)),
        
        StreetArt(title: "Pasolini in Scampia", author: "Jorit", rating: 5, excerpt: "In this mural, street artist Jorit painted the face of the writer Pier Paolo Pasolini. It is a simbol of hope and knowledge in one of the most troubled areas in Naples.", image: "37",
            city: "Scampia", coordinates: CLLocationCoordinate2D(latitude: 40.894189, longitude: 14.239147)),
        

    ]
    
    
    @Published var testFavorite = [StreetArt]()
    @Published var testSearch = [StreetArt]()
    
    private init() {
        if let streetArts = UserDefaults.standard.array(forKey: "Tap") as? [String] {
            for el in streetArts {
                testFavorite.append(contentsOf: testArt.filter({$0.title == el}))
            }

        }
    }
    
    func computeDistance(userLocation: CLLocationCoordinate2D) {
        for (i, art) in testArt.enumerated() {
            let distanceInMeters = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude).distance(from: CLLocation(latitude: art.coordinates!.latitude, longitude: art.coordinates!.longitude)) // result is in meters
            testArt[i].distances = distanceInMeters.advanced(by: 0.0) / 1000
        }
        for (i, art) in testFavorite.enumerated() {
        let distanceInMeters = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude).distance(from: CLLocation(latitude: art.coordinates!.latitude, longitude: art.coordinates!.longitude)) // result is in meters
        testFavorite[i].distances = distanceInMeters.advanced(by: 0.0) / 1000
    }
    }
    func orderDistance() {
        testArt.sort{
            $0.distances < $1.distances
        }
    }
//    func orderDistanceF() {
//        testFavorite.sort{
//            $0.distances < $1.distances
//        }
//    }
    
    func isFavorite(_ art: StreetArt) -> String {
        if testFavorite.contains(where: {
            art.title == $0.title
        }) {
            return "bookmark.fill"
        } else {
            return "bookmark"
        }
    }
}


