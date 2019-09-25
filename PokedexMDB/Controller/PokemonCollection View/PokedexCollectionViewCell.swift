//
//  PokedexCollectionViewCell.swift
//  PokedexMDB
//
//  Created by shaina on 9/19/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class PokedexCollectionViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
