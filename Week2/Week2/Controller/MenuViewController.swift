//
//  MenuViewController.swift
//  Week2
//
//  Created by 이서영 on 2022/08/15.
//

import UIKit

private let cellIdentifier = "menuCell"
private let reusableViewIdentifier = "menuHeader"

class MenuViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var menus = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "메뉴"
        setMenus()
    }
    
    func setMenus() {
        menus.append(MenuModel(imageName: "menu1", name: "추천 메뉴"))
        menus.append(MenuModel(imageName: "menu2", name: "버거 & 세트"))
        menus.append(MenuModel(imageName: "menu3", name: "스낵 & 사이드"))
        menus.append(MenuModel(imageName: "menu4", name: "음료"))
        menus.append(MenuModel(imageName: "menu5", name: "디저트"))
        menus.append(MenuModel(imageName: "menu6", name: "해피밀®"))
        self.collectionView.reloadData()
    }

}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        cell.menuLabel.text = menus[indexPath.row].name
        cell.imageView.image = menus[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets.zero
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 1
        let width = collectionView.frame.width / 2 - 0.5
        let height = width
        return CGSize(width: width , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableViewIdentifier, for: indexPath)
            return headerView
        default:
            assert(false)
        }
    }

}
