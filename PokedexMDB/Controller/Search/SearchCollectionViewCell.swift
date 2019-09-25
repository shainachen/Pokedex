//
//  SearchCollectionViewCell.swift
//  PokedexMDB
//
//  Created by shaina on 9/20/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class SearchCollectionViewCell:  UICollectionViewCell {
    
    @IBOutlet weak var type: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = isSelected ? UIColor.gray.cgColor : UIColor.clear.cgColor
        }
    }
}

