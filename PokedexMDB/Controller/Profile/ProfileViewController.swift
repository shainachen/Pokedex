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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "profileBackground2")!)

        setUpDisplay()
        setImage()
    }
    
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
    @IBAction func selectSearchTheWeb(_ sender: Any) {
        search()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        var favPokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
        if !arrayContains(myArr: favPokemon, p: selectedPokemon) {
            favPokemon.append(selectedPokemon.name)
            UserDefaults.standard.set(favPokemon, forKey: "favorites")
        }
    }
    
    func arrayContains(myArr: [String], p: Pokemon) -> Bool {
        for poke in myArr {
            if poke == p.name {
                return true
            }
        }
        return false
    }
}
