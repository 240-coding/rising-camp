//
//  ReservationViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class ReservationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var reservationMenuView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureReservationMenuView()
        addTapGestureRecognizer()
        

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
    
    func addTapGestureRecognizer() {
        for (index, view) in reservationMenuView.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushNextViewController))
            tapGesture.delegate = self
            view.addGestureRecognizer(tapGesture)
            view.tag = index
        }
    }
    
    @objc func pushNextViewController(_ sender: UITapGestureRecognizer) {
        let identifier = sender.view!.tag == 0 ? "CinemaSelect" : "MovieSelect"
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    
}
