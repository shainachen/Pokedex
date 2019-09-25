//
//  ProfileViewController_UI.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//
import UIKit

extension ProfileViewController {
    /// Configure all labels to display correct information about Pokemon
    func setUpDisplay() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "profileBackground2")!)

        information.roundedButton()
        favorite.roundedButton()
        
        name.text = String(selectedPokemon.name)
        number.text = "Number: " + String(selectedPokemon.number)
        attack.text = "Attack: " + String(selectedPokemon.attack)
        defense.text = "Defense: " + String(selectedPokemon.defense)
        health.text = "Health: " + String(selectedPokemon.health)
        specialAttack.text = "Special Attack: " + String(selectedPokemon.specialAttack)
        specialDefense.text = "Special Defense: " + String(selectedPokemon.specialDefense)
        species.text = "Species: " + String(selectedPokemon.species)
        speed.text = "Speed: " + String(selectedPokemon.speed)
        total.text = "Total: " + String(selectedPokemon.total)
        types.text = "Types: " + String(selectedPokemon.types.joined(separator: ", "))
        
        var myStats = [String]()
        for item in selectedPokemon.stats {
            myStats.append(String(item));
        }
        stats.text = "Stats: " + myStats.joined(separator: "/")
        
    }
    
    
}
