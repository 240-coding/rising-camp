//
//  TagCollectionViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.cornerRadius = contentView.frame.height / 3
    }
}
