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
    
    @IBOutlet weak var pokedexTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDisplayLogic()
    }

    /// Returns the number of rows in section of table view
    ///
    /// - Parameters:
    ///   - tableView
    ///   - section
    /// - Returns number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexArr.count
    }
    
    /// Adds and sets data about the cell image and text
    ///
    /// - Parameters:
    ///   - tableView
    ///   - indexPath

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
    
    /// Sets the cell height
    /// - Parameters:
    ///   - tableView
    ///   - indexPath
    /// - Returns: cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    /// Segues if row of pokemon is selected
    ///
    /// - Parameters:
    ///   - tableView
    ///   - indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokedexArr[indexPath.row]
        performSegue(withIdentifier: "toProfile", sender: self)
    }

}
