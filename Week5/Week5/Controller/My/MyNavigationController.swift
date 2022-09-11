//
//  MyNavigationController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let myViewConroller = storyboard.instantiateViewController(withIdentifier: "My") as? MyViewController, let myNewViewConroller = storyboard.instantiateViewController(withIdentifier: "MyNew") as? MyNewViewController else {
            print("Can't load view controllers")
            return
        }

        // Do any additional setup after loading the view.
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    self.setViewControllers([myNewViewConroller], animated: false)
                }
            }
        }
        else {
            //로그인 필요
            self.setViewControllers([myViewConroller], animated: false)
        }
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
