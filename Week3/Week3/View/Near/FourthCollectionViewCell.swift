//
//  FourthCollectionViewCell.swift
//  Week3
//
//  Created by 이서영 on 2022/08/27.
//

import UIKit

class FourthCollectionViewCell: UICollectionViewCell {
    
    let cellIdentifier = "AlbaCell"
    
    let albaModel: [AlbaModel] = [
        AlbaModel(shop: "싸다아구찜", location: "대현동", title: "주방보조 홀서빙 구합니다", wage: 11000, thumbnail: UIImage(named: "alba1")),
        AlbaModel(shop: "싸다아구찜", location: "대현동", title: "주방보조 홀서빙 구합니다", wage: 11000, thumbnail: UIImage(named: "alba1")),
        AlbaModel(shop: "리버트리카페", location: "대현동", title: "리셉셔니스트/바리스타 구해요 :)", wage: 11000, thumbnail: UIImage(named: "alba2")),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.register(UINib(nibName: "FourthAlbaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        moreButton.layer.borderColor = UIColor.systemGray5.cgColor
        moreButton.layer.borderWidth = 1
    }

}

extension FourthCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FourthAlbaTableViewCell else { return UITableViewCell() }
        
        let data = albaModel[indexPath.row]
        
        cell.shopNameLabel.text = data.shop
        cell.locationLabel.text = data.location
        cell.titleLabel.text = data.title
        cell.wageLabel.text = "시급 \(Utils.numberFormatter(number: data.wage))원"
        cell.thumbnailImageView.image = data.thumbnail ?? UIImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
