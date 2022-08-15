//
//  ViewController.swift
//  Week2
//
//  Created by 이서영 on 2022/08/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
         configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 30),
            logoImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
                
        self.navigationItem.titleView = logoImageView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EN", style: .plain, target: self, action: nil)
    }


}

