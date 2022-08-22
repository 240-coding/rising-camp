//
//  ViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func configureTabBar() {
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "Black")
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.layer.borderWidth = 0.5
        self.tabBarController?.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
    }


}

