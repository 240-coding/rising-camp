//
//  LoginViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        configureTextField(idTextField, "아이디")
        configureTextField(pwTextField, "비밀번호")
    }
    
    // MARK: - Confgirue UI
    func setNavigationItem() {
        let item = UINavigationItem()
        
        item.title = "로그인"
        item.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeViewController))
        
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Set navigation item we created to new navigation bar to display it
        navigationBar.items = [item]
    }
    
    @objc func closeViewController() {
        dismiss(animated: true)
    }
    
    func configureTextField(_ textField: UITextField, _ placeholder: String) {
        let underlineLayer = CALayer()
        let width = CGFloat(1.0)
        underlineLayer.borderColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1).cgColor
        underlineLayer.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        underlineLayer.borderWidth = width
        textField.layer.addSublayer(underlineLayer)
        textField.layer.masksToBounds = true
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : #colorLiteral(red: 0.7533482313, green: 0.7533482313, blue: 0.7533482313, alpha: 1)])
    }
    
    // MARK: - Actions
    @IBAction func pressKakaoLoginButton() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                if let tabBar = self.presentingViewController as? UITabBarController {
                    if let navigationController = tabBar.selectedViewController as? UINavigationController {
                        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyNew")
                        navigationController.setViewControllers([newViewController], animated: true)
                    }
                    tabBar.selectedIndex = 0
                }
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func testNavVc() {
        if let tabBar = self.presentingViewController as? UITabBarController {
            if let navigationController = tabBar.selectedViewController as? UINavigationController {
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyNew")
                navigationController.setViewControllers([newViewController], animated: true)
            }
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func pressLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                if let tabBar = self.presentingViewController as? UITabBarController {
                    tabBar.selectedIndex = 0
                }
                self.dismiss(animated: true)
            }
        }
    }
}
