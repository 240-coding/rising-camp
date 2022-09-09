//
//  HomeEventCollectionViewCell.swift
//  Week5
//
//  Created by 이서영 on 2022/09/09.
//

import UIKit

class HomeEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
}
