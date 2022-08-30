//
//  ViewController.swift
//  Week4
//
//  Created by 이서영 on 2022/08/31.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var toolButtons: [UIButton]!
    
    @IBOutlet weak var bagLabelView: UIView!
    @IBOutlet weak var bagLabel: UILabel!
    
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var selectedTool = -1 // -1: none, 0: 주전자, 1: 팥, 2: 손
    var life = 3
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bagLabelView.layer.cornerRadius = bagLabelView.frame.height / 2
    }
    
    @IBAction func pressedToolButton(_ sender: UIButton) {
        let index = toolButtons.firstIndex(of: sender)!
        sender.isSelected.toggle()
        selectedTool = sender.isSelected ? index : -1
        setButtonState()
    }
    
    func setButtonState() {
        for (index, button) in toolButtons.enumerated() {
            if index == selectedTool {
                button.layer.borderWidth = 3
                button.layer.borderColor = UIColor.red.cgColor
            } else {
                button.isSelected = false
                button.layer.borderWidth = 0
            }
        }
    }


}

