//
//  MenuDetailViewController.swift
//  Week2
//
//  Created by 이서영 on 2022/08/18.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuInfoImageView: UIImageView!
    @IBOutlet weak var kcalLabel: UILabel!
    
    var menuName: String = ""
    var menuImage = UIImage()
    var menuInfoImage = UIImage()
    var kcal: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = menuName
        menuImageView.image = menuImage
        menuInfoImageView.image = menuInfoImage
        kcalLabel.text = "\(kcal) Kcal"
    }
    
    @IBAction func pressedOrderButton(_ sender: UIButton) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
