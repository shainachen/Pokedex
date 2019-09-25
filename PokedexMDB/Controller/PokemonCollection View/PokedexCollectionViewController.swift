//
//  PokedexCollectionViewController.swift
//  PokedexMDB
//
//  Created by shaina on 9/19/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokedexArr = [Pokemon]()
    var selectedPokemon: Pokemon!
    
    @IBOutlet weak var backNav: UINavigationBar!
    @IBOutlet weak var pokedexTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell") as? PokedexCollectionViewCell {
            let Pokemon = pokedexArr[indexPath.row]
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
        selectedPokemon = pokedexArr[indexPath.row]
        performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            if let dest = segue.destination as? ProfileViewController {
                dest.selectedPokemon = selectedPokemon
            }
        }
    }

}
