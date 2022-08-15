//
//  BannerCollectionViewCell.swift
//  Week2
//
//  Created by 이서영 on 2022/08/15.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureImageView(image: String) {
        if let image = UIImage(named: image) {
            bannerImageView.image = image
        }
    }
}
