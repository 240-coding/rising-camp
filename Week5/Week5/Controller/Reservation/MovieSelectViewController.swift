//
//  MovieSelectViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class MovieSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }
    
    func setNavigationItem() {
        let item = UINavigationItem()
        
        item.title = "영화 선택"
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: nil, action: nil)
        item.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeViewController))
        
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Set navigation item we created to new navigation bar to display it
        navigationBar.items = [item]
    }
    
    @objc func closeViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func pressedButton() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CinemaSelect")
        present(nextVC, animated: true)
    }
}
