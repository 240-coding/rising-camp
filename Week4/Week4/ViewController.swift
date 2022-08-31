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
    @IBOutlet var boongButtons: [UIButton]!
    
    @IBOutlet weak var bagLabelView: UIView!
    @IBOutlet weak var bagLabel: UILabel!
    
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var selectedTool = -1 // -1: none, 0: 주전자, 1: 팥, 2: 손
    var boongStates = Array(repeating: -1, count: 8) // -1: none, 0: 반죽, 1: 팥, 2: 뒤집기1, 3: 덜 구움, 4: 제대로 구움, 5: 타버림
    var boongIsRunning = Array(repeating: false, count: 8) // 붕어빵 타이머 동작 여부
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
        setToolButtonState()
    }
    
    func setToolButtonState() {
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
    
    @IBAction func pressedBoongButton(_ sender: UIButton) {
        let index = boongButtons.firstIndex(of: sender)!
        switch selectedTool {
        case 0: // 주전자
            if boongStates[index] == -1 {
                sender.setImage(UIImage(named: "boong1"), for: .normal)
                boongStates[index] = 0
            }
        case 1: // 팥
            if boongStates[index] == 0 {
                sender.setImage(UIImage(named: "boong2"), for: .normal)
                boongStates[index] = 1
            }
        case 2: // 손
            if boongStates[index] == 1 { // 팥 넣고 처음 뒤집은 상태
                sender.setImage(UIImage(named: "boong3"), for: .normal)
                boongStates[index] = 2
            } else if boongStates[index] == 2 { // 뒤집기2
                // 뒤집은 시간에 따라 boong4 or boong5
                sender.setImage(UIImage(named: "boong4"), for: .normal)
                boongStates[index] = 3
            } else if boongStates[index] == 3 { // 2번 뒤집은 후
                // 붕어빵 상태에 따라 가방에 넣을지 버릴지 달라짐
            }
        default:
            return
        }
    }


}

