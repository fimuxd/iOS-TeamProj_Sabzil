//
//  LoginViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBAction func clickedLoginBtn(_ sender: Any) {
        dismissSelf()
        UserDefaults.standard.set(true, forKey: "LoginTest")
    }
    
    @IBAction func clickedFacebookLogin(_ sender: UIButton) {
        // facebookLoginRequest
    }

    @IBAction func clickedSignup(_ sender: UIButton) {
        presentSignupVC()
    }
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func dismissSelf(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func presentSignupVC(){
        let signupVC:SignUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        present(signupVC, animated: true, completion: nil)
    }
}
