//
//  PokedexCollectionViewController_Logic.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension PokedexCollectionViewController{
    
    func setUpDisplayLogic() {
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
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
