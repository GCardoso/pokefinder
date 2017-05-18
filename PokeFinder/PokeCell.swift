//
//  PokeCell.swift
//  PokeFinder
//
//  Created by Guilherme Gomes Cardoso on 5/15/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit

class PokeCell: UITableViewCell {

    var pokemon: Pokemon!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func configureCell(poke: Pokemon) {
        self.pokemon = poke
        name.text = self.pokemon.name.capitalized
        img.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }

}
