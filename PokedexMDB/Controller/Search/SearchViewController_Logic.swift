//
//  SearchViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension SearchViewController {
    /// Set up display to be called in viewDidLoad() - all logic
    func setUpDisplayLogic() {
        
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
        pokedexCollectionView.allowsMultipleSelection = true;
        
        UserDefaults.standard.set([String](), forKey: "favorites")
    }
    
    /// Clears the user's entered filter criteria every time the user returns to page
    func reset() {
        pokemon = PokemonGenerator.getPokemonArray()
        selectedTypes.removeAll()
        name.text = ""
        number.text = ""
        attackPoints.text = ""
        defensePoints.text = ""
        healthPoints.text = ""
    }
    
    /// removes a type from selectedType array based on type name
    ///
    /// - Parameter s: name of type to be removed
    func removeSelectedType(s: String) {
        selectedTypes = selectedTypes.filter{ $0 != s}
    }
    
    /// Generates 20 random pokemon
    func randomGenerationOfPokemon() {
        pokemon.removeAll();
        for _ in 1...20 {
            let randomIndex = Int.random(in: 0..<allPokemon.count)
            pokemon.append(allPokemon[randomIndex])
        }
    }
    
    /// Filters down pokemon list based on entered user criteria to be passed
    /// into the search page
    func filterPokemon() {
        if selectedTypes.count >= 1 {
            for type in selectedTypes {
                pokemon = pokemon.filter({$0.types.contains(type)})
            }
        }
        if attackPoints.hasText {
            if let attackNum = Int(attackPoints.text!) {
                pokemon = pokemon.filter{$0.attack! >= attackNum}
            }
        }
        if defensePoints.hasText {
            if let defenseNum = Int(defensePoints.text!) {
                pokemon = pokemon.filter({$0.defense! >= defenseNum})
            }
        }
        if healthPoints.hasText {
            if let healthNum = Int(healthPoints.text!) {
                pokemon = pokemon.filter({$0.health! >= healthNum})
            }
        }
        if name.hasText {
            pokemon = pokemon.filter({$0.name! == name.text})
        }
        
        if number.hasText {
            if let num = Int(number.text!) {
                pokemon = pokemon.filter({$0.number! == num})
            }
        }
    }
    
    /// Sets pokemon list information for pages
    ///
    /// - Parameters:
    ///   - segue
    ///   - sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            if let dest = segue.destination as? PokedexCollectionViewController {
                dest.pokedexArr = pokemon
            }
        } else if segue.identifier == "toSinglePokemon" {
            if let dest = segue.destination as? ProfileViewController {
                dest.selectedPokemon = pokemon[0]
            }
        }
    }
    
    /// Filters entered user's data to numbers to ensure values like points are numbers
    /// - Parameters:
    ///   - textField: text field to filter
    ///   - range: range of numbers to change
    ///   - string: string of text to filter from
    /// - Returns: filtered string
    func filterToNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> String {
        return string.filter("0123456789".contains)
    }
    
    /// Checks if array contains input string
    ///
    /// - Parameters:
    ///   - myArr: array to check from
    ///   - type: string type description to check in array
    /// - Returns: true if array does contain string, false otherwise
    func arrayContains(myArr: [String], type: String) -> Bool {
        for t in myArr {
            if t == type {
                return true
            }
        }
        return false
    }
    
    /// Add type to selectedTypes array if it does not already exist
    ///
    /// - Parameter index: index of type in the types array to be added
    func addToSelectedTypes(index: Int) {
        if !arrayContains(myArr: selectedTypes, type: types[index]) {
            selectedTypes.append(types[index])
        }
    }
    
    /// Segues to different page depending on if there is one pokemon or more than one in list
    func searchPokemon() {
        if pokemon.count == 1 {
            performSegue(withIdentifier: "toSinglePokemon", sender: self)
        } else if pokemon.count > 1 {
            performSegue(withIdentifier: "toList", sender: self)
        }
    }
}
