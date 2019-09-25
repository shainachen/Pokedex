//
//  FavoritesViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    func setUpDisplayLogic() {
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
        
        favoritePokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
    }
    
    func setUpDisplayLogicWhenAppear() {
        favoritePokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
        pokedexTableView.reloadData()
    }
    
    func findPokemon(name: String) -> Pokemon {
        for pokemon in allPokemon {
            if pokemon.name == name {
                return pokemon
            }
        }
        return allPokemon[0]
    }
}
