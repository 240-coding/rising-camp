//
//  MenuCell.swift
//  Week2
//
//  Created by 이서영 on 2022/08/18.
//

import UIKit

class MenuCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var menuLabel: UILabel!
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
}
