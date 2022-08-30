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
    var selectedTool = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

