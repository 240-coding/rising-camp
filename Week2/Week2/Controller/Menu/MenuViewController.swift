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
        navigationItem.backButtonTitle = ""
        setMenus()
    }
    
    func setMenus() {
        menus.append(MenuModel(imageName: "menu1", name: "추천 메뉴"))
        menus.append(MenuModel(imageName: "menu2", name: "맥모닝 & 세트"))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuListViewController") as? MenuListViewController else { return }
        let title = menus[indexPath.row].name
        let menus: [MenuInfoModel] = [MenuInfoModel(menuName: "치킨 토마토 스낵랩", price: 2800, menuImageName: "menuDetail1"), MenuInfoModel(menuName: "베이컨 토마토 에그 머핀", price: 4300, menuImageName: "menuDetail2"), MenuInfoModel(menuName: "에그 맥머핀", price: 3500, menuImageName: "menuDetail3"), MenuInfoModel(menuName: "베이컨 에그 맥머핀", price: 3800, menuImageName: "menuDetail4"), MenuInfoModel(menuName: "소시지 에그 맥머핀", price: 4000, menuImageName: "menuDetail5"), MenuInfoModel(menuName: "치킨 치즈 머핀", price: 4100, menuImageName: "menuDetail6"), MenuInfoModel(menuName: "상하이 치킨 스낵랩", price: 3000, menuImageName: "menuDetail7"), MenuInfoModel(menuName: "디럭스 브렉퍼스트", price: 5600, menuImageName: "menuDetail8"), MenuInfoModel(menuName: "핫케익 3조각", price: 3800, menuImageName: "menuDetail9"), MenuInfoModel(menuName: "하케익 2조각", price: 3100, menuImageName: "menuDetail10"), MenuInfoModel(menuName: "딸기잼", price: 200, menuImageName: "menuDetail11"), MenuInfoModel(menuName: "핫케익 시럽 추가", price: 400, menuImageName: "menuDetail12"), MenuInfoModel(menuName: "핫케익 버터 추가", price: 300, menuImageName: "menuDetail13")]
        nextViewController.menuList = MenuListModel(title: title, menus: menus)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}
