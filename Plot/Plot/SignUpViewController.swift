//
//  SignUpViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/

    @IBAction func clickedDismiss(_ sender: UIButton) {
        dismissSelf()
    }
    
    @IBAction func clickedSignup(_ sender: UIButton) {
        //signupRequest
        dismissSelf()
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

}
