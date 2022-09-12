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
    let userDefaults = UserDefaults.standard
    var userMovieList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        let headerNib = UINib(nibName: "MyNewHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        let sectionHeaderNib = UINib(nibName: "MyNewSectionHeaderView", bundle: nil)
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        loadUserNickname()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserMovieList()
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
    
    func loadUserMovieList() {
        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
            if let error = error {
                print(error)
            }
            else {
                print("accessTokenInfo() success.")

                //do something
                _ = accessTokenInfo
                guard let userId = accessTokenInfo?.id else {
                    print("ID 불러오기 실패")
                    return
                }
                self.userMovieList = self.userDefaults.object(forKey: String(userId)) as? [String] ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.userMovieList)
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
        return section == 0 ? 0 : userMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userMovieList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            userMovieList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("accessTokenInfo() success.")

                    //do something
                    _ = accessTokenInfo
                    guard let userId = accessTokenInfo?.id else {
                        print("아이디 불러오기 실패")
                        return
                    }
                    self.userDefaults.set(self.userMovieList, forKey: String(userId))
                }
            }
            
            
        } else if editingStyle == .insert {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Header
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
