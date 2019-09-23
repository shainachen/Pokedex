//
//  FavoritesViewController.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritePokemon: [Pokemon]!
    var selectedPokemon: Pokemon!
    
    @IBOutlet weak var pokedexTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
        
        favoritePokemon = UserDefaults.standard.array(forKey: "favorites") as! [Pokemon]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell") as? PokedexCollectionViewCell {
            let Pokemon = favoritePokemon[indexPath.row]
            
            cell.pokemonImageView.image = getImageFromURL(url: Pokemon.imageUrl)
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
        
        print("Selected \(favoritePokemon[indexPath.row].name)")
        
        selectedPokemon = favoritePokemon[indexPath.row]
 //       performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            if let dest = segue.destination as? ProfileViewController {
                dest.selectedPokemon = selectedPokemon
            }
        }
    }

*/
}
