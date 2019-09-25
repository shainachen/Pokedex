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
    
    override func viewDidAppear(_ animated: Bool) {
        reset()
    }
    
    /// Determine the number of items in the collection view
    ///
    /// - Parameters:
    ///   - collectionView
    ///   - section
    /// - Returns: number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return types.count
    }
    
    /// Set and add items to each cell in the collection view
    ///
    /// - Parameters:
    ///   - collectionView
    ///   - indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCollectionCell", for: indexPath) as? SearchCollectionViewCell {
        cell.type.text = types[indexPath.item]
        return cell
        }
        return UICollectionViewCell()
    }
    
    /// Adds type to selected array when cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addToSelectedTypes(index: indexPath.row)
    }
    
    /// Determine the layout of the collection view
    ///
    /// - Parameters:
    ///   - collectionView
    ///   - collectionViewLayout
    ///   - indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dimension = self.pokedexCollectionView.frame.size.width / 4;
    return CGSize(width: dimension, height: dimension)
    }
    
    /// Filters pokemon list based on entered filter criteria and segues to
    /// search page with all pokemon that fit the criteria
    /// - Parameter sender
    @IBAction func selectSearch(_ sender: Any) {
        filterPokemon()
        searchPokemon()
    }
    
    /// Generates 20 random pokemon and segues to
    /// search page with all pokemon
    ///
    /// - Parameter sender
    @IBAction func selectRandom(_ sender: Any) {
        randomGenerationOfPokemon()
        performSegue(withIdentifier: "toList", sender: self)
    }
}

