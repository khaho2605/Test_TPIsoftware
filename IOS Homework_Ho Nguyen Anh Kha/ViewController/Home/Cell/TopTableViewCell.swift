//
//  TopTableViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 7/5/24.
//

import UIKit

final class TopTableViewCell: UITableViewCell {

    var onTapNotiButton: (() -> Void)?
    
    @IBOutlet weak var notiButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapNotiButton(_ sender: UIButton) {
        onTapNotiButton?()
    }
    
    func updateBadgeNoti() {
        notiButton.isSelected = true
    }
}
