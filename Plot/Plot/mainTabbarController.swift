//
//  mainTabbarController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class mainTabbarController: UITabBarController {
    
    func showLogInVC() {
        let logInVC:LoginViewController = LoginViewController()
        let navigation:UINavigationController = UINavigationController(rootViewController: logInVC)
        self.present(navigation, animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
