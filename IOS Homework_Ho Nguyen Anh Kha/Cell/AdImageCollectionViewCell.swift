//
//  AdImageCollectionViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit

class AdImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateImage(with strURL: String) {
        adImageView.load(urlString: strURL)
    }
}
