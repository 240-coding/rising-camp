//
//  SecondCollectionViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bannerView.layer.cornerRadius = 15
    }

}
