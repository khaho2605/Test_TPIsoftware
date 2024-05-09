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
    
    private var usdBalance = ""
    private var khrBalance = ""
    
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
        showBalance(with: !eyesButton.isSelected)
    }
    
    func updateBalance(usd: Double, khr: Double) {
        usdBalance = usd.formattedString
        khrBalance = khr.formattedString
        showBalance(with: !eyesButton.isSelected)
    }
    
    private func showBalance(with isShow: Bool) {
        let hideUSD = String(repeating: "*", count: usdBalance.count)
        let hideKHR = String(repeating: "*", count: khrBalance.count)
        
        usdBalanceTextField.text = isShow ? usdBalance : hideUSD
        khrBalanceTextField.text = isShow ? khrBalance : hideKHR
    }
}
