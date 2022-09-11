//
//  MyNewViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class MyNewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var nickname: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        let headerNib = UINib(nibName: "MyNewHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        let sectionHeaderNib = UINib(nibName: "MyNewSectionHeaderView", bundle: nil)
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        loadUserNickname()
        
    }
    
    func configureNavigationBar() {
        setNavigationBarItems()
        setNavigationBarBackground()
        navigationItem.title = "나의 메가박스"
    }
    
    func loadUserNickname() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                self.nickname = user?.properties?["nickname"]
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func pressLogoutButton() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                guard let myViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "My") as? MyViewController else {
                    print("Can't load MyViewController")
                    return
                }
                self.navigationController?.viewControllers = [myViewController]
                self.tabBarController?.selectedIndex = 0
            }
        }
    }

}

extension MyNewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "하이"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? MyNewHeaderView else {
                print("Can't find header")
                return UIView()
            }
            header.usernameLabel.text = "\(nickname ?? "nickname")님은 일반등급입니다."
            header.logoutButton.addTarget(self, action: #selector(pressLogoutButton), for: .touchUpInside)
            return header
        } else {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? MyNewSectionHeaderView else {
                print("Can't find section header")
                return UIView()
            }
            return header
        }
        
    }
    
    
}
