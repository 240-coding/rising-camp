//
//  ViewController.swift
//  Week1
//
//  Created by 이서영 on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pinkView1: UIView!
    @IBOutlet var pinkView2: UIView!
    @IBOutlet var pinkView3: UIView!
    
    @IBOutlet var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pinkView1.layer.borderColor = UIColor(named: "pink")?.cgColor
        pinkView1.layer.borderWidth = 1
        pinkView1.layer.cornerRadius = pinkView1.frame.height / 2
        
        pinkView2.layer.borderColor = UIColor(named: "pink")?.cgColor
        pinkView2.layer.borderWidth = 1
        pinkView2.layer.cornerRadius = pinkView2.frame.height / 2
        
        pinkView3.layer.borderColor = UIColor(named: "pink")?.cgColor
        pinkView3.layer.borderWidth = 1
        pinkView3.layer.cornerRadius = pinkView3.frame.height / 2
        
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.937254902, alpha: 1)
        
    }


}

