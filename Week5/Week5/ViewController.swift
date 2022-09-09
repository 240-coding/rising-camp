//
//  ViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gradientView.setGradient()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "ticket"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }


}

