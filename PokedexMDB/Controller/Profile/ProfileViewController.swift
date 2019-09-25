//
//  ProfileViewController.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var selectedPokemon: Pokemon!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
     @IBOutlet weak var number: UILabel!
     @IBOutlet weak var attack: UILabel!
     @IBOutlet weak var defense: UILabel!
     @IBOutlet weak var health: UILabel!
     @IBOutlet weak var specialAttack: UILabel!
     @IBOutlet weak var specialDefense: UILabel!
     @IBOutlet weak var species: UILabel!
     @IBOutlet weak var speed: UILabel!
     @IBOutlet weak var total: UILabel!
     @IBOutlet weak var types: UILabel!
     @IBOutlet weak var stats: UILabel!
    
    @IBOutlet weak var information: UIButton!
    @IBOutlet weak var favorite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDisplay()
        setImage()
    }
    
    /// Searches on Safari for pokemon
    ///
    /// - Parameter sender
    @IBAction func selectSearchTheWeb(_ sender: Any) {
        search()
    }
    
    /// Adds pokemon to list of favorite pokemon
    ///
    /// - Parameter sender
    @IBAction func addToFavorites(_ sender: Any) {
        favoritingPokemon()
    }
}
