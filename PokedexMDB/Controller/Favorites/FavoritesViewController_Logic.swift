//
//  FavoritesViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    /// Set up table view and data for viewDidLoad()
    func setUpDisplayLogic() {
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
        
        favoritePokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
    }
    
    /// Set up table view and data for viewDidAppear()
    func setUpDisplayLogicWhenAppear() {
        favoritePokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
        pokedexTableView.reloadData()
    }
    
    /// Find Pokemon in array of all pokemon given name
    ///
    /// - Parameter name: name of pokemon
    /// - Returns: Pokemon corresponding to that name
    func findPokemon(name: String) -> Pokemon {
        for pokemon in allPokemon {
            if pokemon.name == name {
                return pokemon
            }
        }
        return allPokemon[0]
    }
}
