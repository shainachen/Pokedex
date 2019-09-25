//
//  ProfileViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//
import UIKit

extension ProfileViewController {
    func search() {
        let url = "https://google.com/search?q=" + selectedPokemon.name
        guard let workingUrl = URL(string: url) else {
            return
        }
        UIApplication.shared.open(workingUrl)
    }
    
    func setImage() {
        guard let myURL = URL(string: selectedPokemon.imageUrl) else {
            return
        }
        
        let data = try? Data(contentsOf: myURL)
        if let imageData = data {
            img.image = UIImage(data: imageData)
        }
    }
    
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
    func arrayContains(myArr: [String], p: Pokemon) -> Bool {
        for poke in myArr {
            if poke == p.name {
                return true
            }
        }
        return false
    }
    
    func favoritingPokemon() {
        var favPokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
        if !arrayContains(myArr: favPokemon, p: selectedPokemon) {
            favPokemon.append(selectedPokemon.name)
            UserDefaults.standard.set(favPokemon, forKey: "favorites")
        }
    }
}
