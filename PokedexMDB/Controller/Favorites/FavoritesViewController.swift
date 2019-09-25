//
//  FavoritesViewController.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favoritePokemon: [String]!
    var selectedPokemon: Pokemon!
    var allPokemon = PokemonGenerator.getPokemonArray()
    @IBOutlet weak var pokedexTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDisplayLogic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpDisplayLogicWhenAppear()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell") as? FavoriteTableViewCell {
            let pokemonName = favoritePokemon[indexPath.row]
            let Pokemon = findPokemon(name: pokemonName)
            guard let myURL = URL(string: Pokemon.imageUrl) else {
                return cell
            }
            let data = try? Data(contentsOf: myURL)
            if let imageData = data {
                cell.pokemonImageView.image = UIImage(data: imageData)
            }
            cell.pokemonName.text = Pokemon.name
            cell.pokemonNumber.text = String(Pokemon.number)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = findPokemon(name: favoritePokemon[indexPath.row])
    }
}
