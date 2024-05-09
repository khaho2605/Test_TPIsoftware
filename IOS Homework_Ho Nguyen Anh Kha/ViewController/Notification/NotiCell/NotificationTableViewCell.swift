//
//  NotificationTableViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(noti: Notification) {
        newView.isHidden = noti.status
        titleLabel.text = noti.title
        dateTimeLabel.text = noti.updateDateTime
        messageLabel.text = noti.message
    }
}
