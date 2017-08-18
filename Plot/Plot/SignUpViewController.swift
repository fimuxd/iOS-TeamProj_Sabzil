//
//  SignUpViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordCheckTF: UITextField!
    @IBOutlet weak var nickNameTF: UITextField!
    
    @IBAction func clickedDismiss(_ sender: UIButton) {
        dismissSelf()
    }
    
    @IBAction func clickedSignup(_ sender: UIButton) {
        //signupRequest
        if idTF.text != "" && passwordTF.text != "" && passwordCheckTF.text != "" && nickNameTF.text != "" {
            signUpRequest()
            dismissSelf()
        }else {
            callAlert()
        }
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
    
    func texCustomButton_RoundtFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case idTF:
            self.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        case passwordTF:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 50)
        case passwordCheckTF:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 100)
        case nickNameTF:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 150)
        default:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idTF:
            self.passwordTF.becomeFirstResponder()
            return true
        case passwordTF:
            self.passwordCheckTF.becomeFirstResponder()
            return true
        case passwordCheckTF:
            self.nickNameTF.becomeFirstResponder()
            return true
        case nickNameTF:
            self.view.endEditing(true)
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        return true

        default:
            self.view.endEditing(true)
            return true
        }
    }
    
    func dismissSelf(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpRequest(){
        
        Auth.auth().createUser(withEmail: self.idTF.text!, password: self.passwordTF.text!) { (user, error) in
            if let error = error {
                print("error://",error)
                return
            }
            
            guard let userName = self.nickNameTF.text else {return}
            
            guard let uid = user?.uid else {return}
            
            let dic:[String:Any] = [Constants.user_ID:uid,
                                    Constants.user_Email:self.idTF.text!,
                                    Constants.user_Name:userName,
                                    Constants.user_Password:self.passwordTF.text!,
                                    Constants.user_ProfileImgURL:""]
            
            Database.database().reference().child("UserData").child(uid).setValue(dic)
            print("호출됨")
            
        }
        
        
        
        
        
        
    }
    
    func callAlert(){
        let errorAlert:UIAlertController = UIAlertController.init(title: "회원가입 실패", message: "빈칸을 채워주세요", preferredStyle: .alert)
        let okBtn:UIAlertAction=UIAlertAction.init(title: "확인", style: .cancel, handler: nil)
        errorAlert.addAction(okBtn)
        present(errorAlert, animated: true, completion: nil)
    }
    
    func signUpActionHandle(){
        Auth.auth().createUser(withEmail: idTF.text!, password: passwordTF.text!) { (user, error) in
            if let error = error {
                print("error!!!!//",error)
                return
            }
            guard let userName = self.nickNameTF.text else { return }
            //success
        }
        
    }
}
