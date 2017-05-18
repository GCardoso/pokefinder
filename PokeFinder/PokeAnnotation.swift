//
//  PokeAnnotation.swift
//  PokeFinder
//
//  Created by Mark Price on 7/25/16.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import Foundation
import MapKit

class PokeAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        self.pokemonName = pokemon[pokemonNumber - 1].capitalized
        self.title = self.pokemonName
    }
}

