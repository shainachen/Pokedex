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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectSearchTheWeb(_ sender: Any) {
        
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        var favPokemon = UserDefaults.standard.array(forKey: "favorites") as! [Pokemon]
        favPokemon.append(selectedPokemon)
        UserDefaults.standard.set(favPokemon, forKey: "favorites")
    }
    func setUpDisplay() {
        number.text = "Number: " + String(selectedPokemon.number)
        attack.text = "Attack: " + String(selectedPokemon.attack)
        defense.text = "Defense: " + String(selectedPokemon.defense)
        health.text = "Health: " + String(selectedPokemon.health)
        specialAttack.text = "Special Attack: " + String(selectedPokemon.specialAttack)
        specialDefense.text = "Special Defense: " + String(selectedPokemon.specialDefense)
        species.text = "Species: " + String(selectedPokemon.species)
        speed.text = "Speed: " + String(selectedPokemon.speed)
        total.text = "Total: " + String(selectedPokemon.total)
        types.text = "Types: " + String(selectedPokemon.types.joined(separator: ", "))
       
        var myStats = [String]()
        for item in selectedPokemon.stats {
            myStats.append(String(item));
        }
        stats.text = "Stats: " + myStats.joined(separator: "/")
    }
}
