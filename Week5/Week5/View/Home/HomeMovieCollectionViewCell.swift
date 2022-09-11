//
//  HomeMovieCollectionViewCell.swift
//  Week5
//
//  Created by 이서영 on 2022/09/10.
//

import UIKit

class HomeMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reservationButton.layer.cornerRadius = 10
        
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
