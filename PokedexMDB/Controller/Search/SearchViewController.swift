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
    
    var types = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy","Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
    var allPokemon = PokemonGenerator.getPokemonArray()
    var pokemon = PokemonGenerator.getPokemonArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDisplayLogic()
        setUpDisplayUI()
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

    override func viewDidAppear(_ animated: Bool) {
       reset()
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
        addToSelectedTypes(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dimension = self.pokedexCollectionView.frame.size.width / 4;
    return CGSize(width: dimension, height: dimension)
    
    }
    @IBAction func selectSearch(_ sender: Any) {
        filterPokemon()
        searchPokemon()
    }
    
    @IBAction func selectRandom(_ sender: Any) {
        randomGenerationOfPokemon()
        performSegue(withIdentifier: "toList", sender: self)
    }
}

