//
//  ShopCollectionViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var buttonActive = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
    }
    
    @IBAction func pressedHeartButton() {
//        heartButton.imageView?.image = buttonActive ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
//        heartButton.setBackgroundImage(buttonActive ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
//        buttonActive.toggle()
//        
//        print(buttonActive)
    }

}
