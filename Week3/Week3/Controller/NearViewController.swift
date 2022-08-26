//
//  NearViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class NearViewController: UIViewController {
    
    let cellIdentifier = ["NearMenu", "SecondCell", "ThirdCell", "FourthCell"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAddButton()
                
        self.collectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier[1])
        self.collectionView.register(UINib(nibName: "ThirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier[2])
        self.collectionView.register(UINib(nibName: "FourthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier[3])
    }
    
    func configureAddButton() {
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.shadowColor = UIColor.lightGray.cgColor
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addButton.layer.shadowRadius = 5
    }

}

extension NearViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier[indexPath.section], for: indexPath) as? NearMenuCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier[indexPath.section], for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier[2], for: indexPath) as? ThirdCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier[3], for: indexPath) as? FourthCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 225)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width, height: 145)
        } else if indexPath.section == 2 {
            return CGSize(width: collectionView.frame.width, height: 430)
        } else {
            return CGSize(width: collectionView.frame.width, height: 600)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 10)
    }

    
}
