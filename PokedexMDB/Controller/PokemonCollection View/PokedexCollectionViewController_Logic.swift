//
//  PokedexCollectionViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension PokedexCollectionViewController{
    
    /// Configure table view for viewDidLoad()
    func setUpDisplayLogic() {
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
    }
    
    /// Returns image corresponding to input url
    ///
    /// - Parameter url: url to find image from
    /// - Returns: UIImage from the input url
    func getImageFromURL(url: String) -> UIImage {
        let myUrl = URL(string: url)
        let data = try? Data(contentsOf: myUrl!)
        return UIImage(data: data!)!
    }
    
    /// Sets the selected pokemon of destination controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            if let dest = segue.destination as? ProfileViewController {
                dest.selectedPokemon = selectedPokemon
            }
        }
    }
}
