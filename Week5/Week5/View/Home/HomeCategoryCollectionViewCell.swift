//
//  HomeCategoryCollectionViewCell.swift
//  Week5
//
//  Created by 이서영 on 2022/09/10.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        bottomView.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                label.font = .systemFont(ofSize: 17)
                label.textColor = UIColor(named: "navy")
                bottomView.isHidden = false
            } else {
                label.font = .systemFont(ofSize: 17, weight: .light)
                label.textColor = .gray
                bottomView.isHidden = true
            }
        }
    }
    
    func configureUnselectedStatus() {
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .gray
        bottomView.isHidden = true
    }
    
    func configureSelectedStatus() {
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "navy")
        bottomView.isHidden = false
    }
}
