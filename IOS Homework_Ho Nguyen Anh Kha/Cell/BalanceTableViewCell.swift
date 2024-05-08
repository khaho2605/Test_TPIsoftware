//
//  BalanceTableViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 7/5/24.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var eyesButton: UIButton!
    @IBOutlet weak var usdBalanceTextField: UITextField!
    @IBOutlet weak var khrBalanceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapEyeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        usdBalanceTextField.isSecureTextEntry = sender.isSelected
        khrBalanceTextField.isSecureTextEntry = sender.isSelected

    }
    
}
