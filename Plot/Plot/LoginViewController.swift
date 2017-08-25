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
            
            guard let realUser = user else {return print("페북리얼유저 없어요")}
                let userEmail = realUser.providerData[0].providerID
                let uid = user?.uid
                let userName = realUser.providerData[0].displayName
            
            let dic:[String:Any] = [Constants.user_ID:uid,
                                    Constants.user_Email:userEmail,
                                    Constants.user_Name:userName,
                                    Constants.user_Password:"",
                                    Constants.user_ProfileImgURL:""]
            
            Database.database().reference().child("UserData").child(uid!).setValue(dic)
            print("호출됨")
            
            
        }
        FBSDKLoginManager().logOut();
        UserDefaults.standard.set(true, forKey: "loginFlag")
        

        self.presentTabbarController()
        
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
            self.logInActionHandle()
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.bool(forKey: "loginFlag") {
            print("트루로 들어왔슴니다")
            presentTabbarController()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.facebookLoginBtn.delegate = self
        facebookLoginBtn.layer.frame.size.height = 44
        
        //왼쪽패딩주는건데 메모리를 겁나먹어서 주석처리함
        //        let textFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: idTF.frame.size.height))
        //        idTF.leftView = textFieldPadding
        //        idTF.leftViewMode = .always
        //        passwordTF.leftView = textFieldPadding
        //        passwordTF.leftViewMode = .always
        
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
    
    func presentTabbarController(){
        let tabbarController:mainTabbarController = storyboard?.instantiateViewController(withIdentifier: "mainTabbarController") as! mainTabbarController
        present(tabbarController, animated: true, completion: nil)
    }
    
    
    
    func logInActionHandle() {
        
        Auth.auth().signIn(withEmail: self.idTF.text!, password: self.passwordTF.text!) { (user, error) in
            if let error = error {
                print("error://", error)
                self.callAlert()
                return
            }
            UserDefaults.standard.set(true, forKey: "loginFlag")
            //                print("로그인핸들러 셋한 후: \(UserDefaults.standard.object(forKey: "currentUser"))")
            self.presentTabbarController()
        }
        
    }
    
    func callAlert() {
        let errorAlert:UIAlertController = UIAlertController.init(title: "로그인 실패", message: "아이디와 비밀번호를 확인해주세요", preferredStyle: .alert)
        let okBtn:UIAlertAction = UIAlertAction.init(title: "확인", style: .cancel, handler: nil)
        errorAlert.addAction(okBtn)
        present(errorAlert, animated: true, completion: nil)
    }
    
}
