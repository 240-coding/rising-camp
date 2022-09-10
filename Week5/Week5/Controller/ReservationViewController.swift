//
//  ReservationViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet var reservationMenuView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureReservationMenuView()
    }
    
    func configureNavigationBar() {
        setNavigationBarBackground()
        setNavigationBarItems()
        navigationItem.title = "예매"
    }
    
    func configureReservationMenuView() {
        reservationMenuView.forEach { view in
            view.layer.cornerRadius = 5
            
            view.layer.shadowOpacity = 0.10
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowRadius = 8.0
            
            view.layer.masksToBounds = false
            
        }
        
    }
    
}
