//
//  SearchViewController_UI.swift
//  PokedexMDB
//
//  Created by shaina on 9/24/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension SearchViewController {
    func setUpDisplayUI() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        search.roundedButton()
        randomize.roundedButton()
    }
    
    /// Changes the cell appearance upon selection/deselection
    ///
    /// - Parameters:
    ///   - collectionView
    ///   - indexPath
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCollectionCell", for: indexPath) as? SearchCollectionViewCell {
                    removeSelectedType(s: cell.type.text!)
                }
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
}

extension UIButton{
    /// Rounds the corners of the UIButton
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
