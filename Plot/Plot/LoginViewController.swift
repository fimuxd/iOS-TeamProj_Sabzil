//
//  LoginViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class LoginViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, FBSDKLoginButtonDelegate {
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {

    }
    
    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error!) {
        if(result?.token == nil){
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if error != nil {
                // ...
                return
            }
        }
        FBSDKLoginManager().logOut();
        
    }
    

        /*******************************************/
        // MARK: -  Outlet                         //
        /*******************************************/
        
        
        @IBOutlet weak var facebookLoginBtn: FBSDKLoginButton!
        
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var idTF: UITextField!
        @IBOutlet weak var passwordTF: UITextField!
        
        @IBAction func clickedLoginBtn(_ sender: Any) {
            
            if idTF.text != "" && passwordTF.text != ""{
                dismissSelf()
                UserDefaults.standard.set(true, forKey: "LoginTest")
            }else{
                callAlert()
            }
        }
        
        @IBAction func clickedSignup(_ sender: UIButton) {
            presentSignupVC()
        }
        
        
        /*******************************************/
        // MARK: -  LifeCycle                      //
        /*******************************************/
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.scrollView.delegate = self
            self.facebookLoginBtn.delegate = self
            facebookLoginBtn.layer.frame.size.height = 44
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*******************************************/
        // MARK: -  Func                           //
        /*******************************************/
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.scrollView.contentOffset = CGPoint.init(x: 0, y: 90)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case idTF:
                passwordTF.becomeFirstResponder()
                return true
            default:
                self.view.endEditing(true)
                self.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                return true
            }
        }
        
        @IBAction func tappedBlackView(_ sender: UITapGestureRecognizer) {
            
            self.view.endEditing(true)
            self.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
            
        }
        func dismissSelf(){
            self.dismiss(animated: true, completion: nil)
        }
        
        func presentSignupVC(){
            let signupVC:SignUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            present(signupVC, animated: true, completion: nil)
        }
        
        func callAlert() {
            let errorAlert:UIAlertController = UIAlertController.init(title: "로그인 실패", message: "아이디와 비밀번호를 확인해주세요", preferredStyle: .alert)
            let okBtn:UIAlertAction = UIAlertAction.init(title: "확인", style: .cancel, handler: nil)
            errorAlert.addAction(okBtn)
            present(errorAlert, animated: true, completion: nil)
        }
}
