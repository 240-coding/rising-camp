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
    
    var boongStates = Array(repeating: -1, count: 8) // -1: none, 0: 반죽, 1: 팥, 2: 뒤집기1, 3: 뒤집기2
    var boongGrillLevel = Array(repeating: 0, count: 8) // 0: 덜 구움, 1: 제대로 구움, 2: 타버림
    var boongIsRunning = Array(repeating: false, count: 8) // 붕어빵 타이머 동작 여부
    var boongTimer = Array(repeating: Timer(), count: 8)
    var boongTimeCount = Array(repeating: 0, count: 8)
    
    var bagCount = 0
    
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
                DispatchQueue.global().async {
                    self.boongIsRunning[index] = true
                    let runLoop = RunLoop.current
                    self.boongTimer[index] = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countBoongTime(_:)), userInfo: ["index": index], repeats: true)
                    
                    while self.boongIsRunning[index] {
                        runLoop.run(until: Date().addingTimeInterval(0.1))
                    }
                }
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
                if boongGrillLevel[index] == 0 {
                    sender.setImage(UIImage(named: "boong4"), for: .normal)
                } else if boongGrillLevel[index] == 1 {
                    sender.setImage(UIImage(named: "boong5"), for: .normal)
                } else {
                    sender.setImage(UIImage(named: "boong6"), for: .normal)
                }
                boongStates[index] = 3
            } else if boongStates[index] == 3 { // 2번 뒤집은 후
                // 붕어빵 상태에 따라 가방에 넣을지 버릴지 달라짐
                if boongGrillLevel[index] == 1 { // 잘 구운 붕어빵만 봉투에 넣음
                    bagCount += 1
                    bagLabel.text = String(bagCount)
                    score += 10
                    scoreLabel.text = String(score)
                }
                initBoongs(index)
            }
        default:
            return
        }
    }
    
    @objc func countBoongTime(_ sender: Timer) {
        guard let userInfo = sender.userInfo as? Dictionary<String, Int> else {
            return
        }
        guard let index = userInfo["index"] else {
            return
        }
        boongTimeCount[index] += 1
        if boongTimeCount[index] <= 5 {
            boongGrillLevel[index] = 0
        } else if boongTimeCount[index] <= 12 {
            boongGrillLevel[index] = 1
        } else {
            boongGrillLevel[index] = 2
        }
    }
    
    func initBoongs(_ index: Int) {
        boongTimer[index].invalidate()
        boongIsRunning[index] = false
        boongButtons[index].setImage(UIImage(named: "boong0"), for: .normal)
        boongStates[index] = -1
        boongGrillLevel[index] = 0
        boongTimeCount[index] = 0
    }


}
