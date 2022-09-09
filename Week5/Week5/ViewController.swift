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
    }


}

