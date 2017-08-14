//
//  Popup.swift
//  Plot
//
//  Created by joe on 2017. 8. 8..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class Popup: UIViewController {
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    var senderTag:Int!
    
    @IBAction func tappedBlackOut(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var starPointPopup: UIView!
    @IBOutlet weak var commentPopup: UIView!

    @IBOutlet weak var commentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var starPointBottomConstranint: NSLayoutConstraint!
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if senderTag == 1 {
            commentPopup.isHidden = true
            starPointBottomConstranint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
        }else if senderTag == 2 {
            starPointPopup.isHidden = true
            commentViewBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    

}
