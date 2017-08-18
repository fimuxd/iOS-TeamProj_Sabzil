//
//  StarPointPopupViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 18..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class StarPointPopupViewController: UIViewController {

    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    
    @IBAction func tappedBlackOut(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBOutlet weak var starPointBottomConstranint: NSLayoutConstraint!
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

            starPointBottomConstranint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.post(name: NSNotification.Name("dismissPopup"), object: self)
    }
    

}
