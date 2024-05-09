//
//  FavoriteCollectionViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(with favorite: Favorite) {
        let transType = TransType(rawValue: favorite.transType)
        imageView.image = transType?.image
        titleLabel.text = favorite.nickname
    }
}
