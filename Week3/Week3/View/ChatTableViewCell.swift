//
//  ChatTableViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messagePhotoImageView: UIImageView!
    
    @IBOutlet var messageLabelTrailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.systemGray4.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        badgeImageView.layer.masksToBounds = true
        badgeImageView.layer.borderWidth = 1
        badgeImageView.layer.borderColor = UIColor.white.cgColor
        badgeImageView.layer.cornerRadius = badgeImageView.frame.height / 2
        
        messagePhotoImageView.layer.masksToBounds = true
        messagePhotoImageView.layer.cornerRadius = 3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
