//
//  MenuListViewController.swift
//  Week2
//
//  Created by 이서영 on 2022/08/18.
//

import UIKit

private let cellIdentifier = "menuListCell"

class MenuListViewController: UIViewController {
    
    var menuList = MenuListModel(title: "", menus: [])
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = menuList.title
        navigationItem.backButtonTitle = ""
    }
    
}

extension MenuListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MenuListTableViewCell else { return UITableViewCell() }
        let menuData = menuList.menus[indexPath.row]
        cell.menuNameLabel.text = menuData.menuName
        cell.priceLabel.text = String(menuData.price)
        cell.menuImageView.image = menuData.menuImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuDetailViewController") as? MenuDetailViewController else { return }
        nextViewController.menuName = "단품 - 치킨 토마토 스낵랩"
        nextViewController.menuImage = UIImage(named: "menuImage") ?? UIImage()
        nextViewController.menuInfoImage = UIImage(named: "menuInfo") ?? UIImage()
        nextViewController.kcal = 264
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
