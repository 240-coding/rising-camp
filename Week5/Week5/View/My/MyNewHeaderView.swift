//
//  MyNewHeaderView.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class MyNewHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradient()
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
    }
    
    @IBAction func pressLogoutButton() {
        print("LOGOUT")
    }

}
