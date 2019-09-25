//
//  ProfileViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//
import UIKit

extension ProfileViewController {
    /// Searches Google on Safari for selected pokemon
    func search() {
        let url = "https://google.com/search?q=" + selectedPokemon.name
        guard let workingUrl = URL(string: url) else {
            return
        }
        UIApplication.shared.open(workingUrl)
    }
    
    /// Sets the image of the Pokemon
    func setImage() {
        guard let myURL = URL(string: selectedPokemon.imageUrl) else {
            return
        }
        
        let data = try? Data(contentsOf: myURL)
        if let imageData = data {
            img.image = UIImage(data: imageData)
        }
    }
    
    /// Retreives an image from given URL
    ///
    /// - Parameter url: give url of image
    /// - Returns: UIImage corresponding to the url
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
    /// Check if array of pokemon contains the Pokemon with the input name
    ///
    /// - Parameters:
    ///   - myArr: list of all pokemon names
    ///   - p: Pokemon to check array with
    /// - Returns: true if pokemon is found in array, false otherwise
    func arrayContains(myArr: [String], p: Pokemon) -> Bool {
        for poke in myArr {
            if poke == p.name {
                return true
            }
        }
        return false
    }
    
    /// Favorites pokemon by adding it to array if it does not already exist
    func favoritingPokemon() {
        var favPokemon = UserDefaults.standard.array(forKey: "favorites") as! [String]
        if !arrayContains(myArr: favPokemon, p: selectedPokemon) {
            favPokemon.append(selectedPokemon.name)
            UserDefaults.standard.set(favPokemon, forKey: "favorites")
        }
    }
}
