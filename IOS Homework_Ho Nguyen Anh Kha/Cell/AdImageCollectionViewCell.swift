//
//  AdImageCollectionViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit
import Kingfisher

class AdImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateImage(with strURL: String) {
        let url = URL(string: "https://willywu0201.github.io/data/banner1.jpg")
        adImageView.kf.setImage(with: url)
    }
}
