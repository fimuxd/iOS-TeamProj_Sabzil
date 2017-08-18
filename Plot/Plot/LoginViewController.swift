//
//  LoginViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func clickedLoginBtn(_ sender: Any) {
        
        if idTF.text != "" && passwordTF.text != ""{
            logInActionHandle()
            dismissSelf()
        }else{
            callAlert()
        }
    }
    
    @IBAction func clickedFacebookLogin(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile], viewController: self) { result in
        
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, _, let userInfo):
                print("토큰:" + userInfo.authenticationToken)
                print("Permissions:" + "\(grantedPermissions.map{"\($0)"})")
            }
            
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
    
    func logInActionHandle() {
        Auth.auth().signIn(withEmail: self.idTF.text!, password: self.passwordTF.text!) { (user, error) in
            if let error = error {
                print("error://", error)
                return
            }
        }
    }
}
