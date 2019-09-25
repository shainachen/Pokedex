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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
    
        UserDefaults.standard.set([String](), forKey: "favorites")
        
        search.roundedButton()
        randomize.roundedButton()
        pokedexCollectionView.allowsMultipleSelection = true;
    // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCollectionCell", for: indexPath) as? SearchCollectionViewCell {
                    removeSelectedType(s: cell.type.text!)
                }
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
    
    func removeSelectedType(s: String) {
        selectedTypes = selectedTypes.filter{ $0 != s}
    }
    override func viewDidAppear(_ animated: Bool) {
        pokemon = PokemonGenerator.getPokemonArray()
        selectedTypes.removeAll()
        name.text = ""
        number.text = ""
        attackPoints.text = ""
        defensePoints.text = ""
        healthPoints.text = ""
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
        if !arrayContains(myArr: selectedTypes, type: types[indexPath.row]) {
            selectedTypes.append(types[indexPath.row])
        }
        print("all selected types: \(selectedTypes.count)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dimension = self.pokedexCollectionView.frame.size.width / 4;
    return CGSize(width: dimension, height: dimension)
    
    }
    @IBAction func selectSearch(_ sender: Any) {
        filterPokemon()
        for p in pokemon {
            print("searching includes: ", p.name)
        }
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
            if let dest = segue.destination as? PokedexCollectionViewController {
                dest.pokedexArr = pokemon
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
    
    func arrayContains(myArr: [String], type: String) -> Bool {
        for t in myArr {
            if t == type {
                return true
            }
        }
        return false
    }
}

extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
