//
//  ThirdCollectionViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    
    let cellIdentifier = "ShopCell"
    
    let shopModel: [ShopModel] = [
        ShopModel(itemImage: UIImage(named: "shopitem1"), shopName: "예맛당", distance: "1.9km", itemName: "황치즈 마카롱", price: 3000, favorite: 9),
        ShopModel(itemImage: UIImage(named: "shopitem2"), shopName: "예맛당", distance: "1.9km", itemName: "레몬젤라또", price: 3000, favorite: 3),
        ShopModel(itemImage: UIImage(named: "shopitem3"), shopName: "예맛당", distance: "1.9km", itemName: "말차초코", price: 3000, favorite: 2),
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib(nibName: "ShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }

}

extension ThirdCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ShopCollectionViewCell else { return UICollectionViewCell() }
        let data = shopModel[indexPath.row]
        cell.imageView.image = data.itemImage ?? UIImage()
        cell.shopNameLabel.text = data.shopName
        cell.distanceLabel.text = data.distance
        cell.itemLabel.text = data.itemName
        cell.priceLabel.text = Utils.numberFormatter(number: data.price) + "원"
        cell.favoriteLabel.text = "관심 \(data.favorite)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}
