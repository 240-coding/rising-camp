//
//  MyViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        setNavigationBarItems()
        setNavigationBarBackground()
        navigationItem.title = "나의 메가박스"
    }
    
    @IBAction func pressLoginButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
            return
        }
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
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
