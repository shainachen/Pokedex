//
//  SearchViewController.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var attackPoints: UITextField!
    @IBOutlet weak var defensePoints: UITextField!
    @IBOutlet weak var healthPoints: UITextField!
    @IBOutlet weak var randomize: UIButton!
    @IBOutlet weak var search: UIButton!
    var selectedTypes = [String]()
    
    var types = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy",
                 "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var allPokemon = PokemonGenerator.getPokemonArray()
    var pokemon = PokemonGenerator.getPokemonArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
    
        UserDefaults.standard.set([Pokemon](), forKey: "favorites")
    // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pokemon = PokemonGenerator.getPokemonArray()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCollectionCell", for: indexPath) as? SearchCollectionViewCell {
        cell.type.text = types[indexPath.item]
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(types[indexPath.row])")
        selectedTypes.append(types[indexPath.row])
        print("all selected types: \(selectedTypes.count)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dimension = self.pokedexCollectionView.frame.size.width / 4;
    return CGSize(width: dimension, height: dimension)
    
    }
    @IBAction func selectSearch(_ sender: Any) {
        filterPokemon()
        if pokemon.count == 1 {
            performSegue(withIdentifier: "toSinglePokemon", sender: self)
        } else if pokemon.count > 1 {
            performSegue(withIdentifier: "toList", sender: self)
        }
    }
    
    @IBAction func selectRandom(_ sender: Any) {
        randomGenerationOfPokemon()
        performSegue(withIdentifier: "toList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            print("performing to list")
            if let dest = segue.destination as? PokedexCollectionViewController {
                dest.pokedexArr = pokemon
                print("pokemon arr:", pokemon.count)

                print("destination arr:", dest.pokedexArr.count)
            }
        } else if segue.identifier == "toSinglePokemon" {
            if let dest = segue.destination as? ProfileViewController {
                dest.selectedPokemon = pokemon[0]
            }
        }
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
                pokemon = pokemon.filter({$0.attack >= attackNum})
            }
        }
        if defensePoints.hasText {
            if let defenseNum = Int(defensePoints.text!) {
                pokemon = pokemon.filter({$0.defense >= defenseNum})
            }
        }
        if healthPoints.hasText {
            if let healthNum = Int(healthPoints.text!) {
                pokemon = pokemon.filter({$0.health >= healthNum})
            }
        }
        if name.hasText {
            pokemon = pokemon.filter({$0.name! == name.text})
        }
        
        if number.hasText {
            if let num = Int(number.text!) {
                pokemon = pokemon.filter({$0.number == num})
            }
        }
        
        for poke in pokemon {
            print("Name:", poke.name)
            for t in poke.types {
                print("Type:", t)
            }
            print("Attack Points:", poke.attack)
            print("number:", poke.number)
        }
    }
    
    func filterToNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> String {
        // remove non-numerics and compare with original string
        return string.filter("0123456789".contains)
    }
}
