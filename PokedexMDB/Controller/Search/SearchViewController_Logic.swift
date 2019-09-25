//
//  SearchViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension SearchViewController {
    func setUpDisplayLogic() {
        
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
        pokedexCollectionView.allowsMultipleSelection = true;
        
        UserDefaults.standard.set([String](), forKey: "favorites")
    }
    
    func reset() {
        pokemon = PokemonGenerator.getPokemonArray()
        selectedTypes.removeAll()
        name.text = ""
        number.text = ""
        attackPoints.text = ""
        defensePoints.text = ""
        healthPoints.text = ""
    }
    
    func removeSelectedType(s: String) {
        selectedTypes = selectedTypes.filter{ $0 != s}
    }
    
    func randomGenerationOfPokemon() {
        pokemon.removeAll();
        for _ in 1...20 {
            let randomIndex = Int.random(in: 0..<allPokemon.count)
            pokemon.append(allPokemon[randomIndex])
        }
    }
    
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
    
    func filterToNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> String {
        return string.filter("0123456789".contains)
    }
    
    func arrayContains(myArr: [String], type: String) -> Bool {
        for t in myArr {
            if t == type {
                return true
            }
        }
        return false
    }
    
    func addToSelectedTypes(index: Int) {
        if !arrayContains(myArr: selectedTypes, type: types[index]) {
            selectedTypes.append(types[index])
        }
    }
    
    func searchPokemon() {
        if pokemon.count == 1 {
            performSegue(withIdentifier: "toSinglePokemon", sender: self)
        } else if pokemon.count > 1 {
            performSegue(withIdentifier: "toList", sender: self)
        }
    }
}
