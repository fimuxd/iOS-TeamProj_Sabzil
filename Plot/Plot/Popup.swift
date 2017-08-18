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
    
    @IBAction func tappedBlackOut(_ sender: UITapGestureRecognizer) {
        dismissSelf()
    }
    
    @IBOutlet weak var commentPopupConstraint: NSLayoutConstraint!
    
    @IBAction func clickedCancelBtn(_ sender: Any) {
        dismissSelf()
    }
    
    @IBAction func clickedSaveBtn(_ sender: UIButton) {
        //각 전시 데이터와 해당 유저데이터에 코멘트 저장
        dismissSelf()
    }
    
    @IBAction func clickedStarPointPopup(_ sender: UIButton) {
        presentStarPointPopup()
    }
    
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        commentPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.post(name: NSNotification.Name("dismissPopup"), object: self)
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "StarPointPopup") as! StarPointPopupViewController
        present(popup, animated: true, completion: nil)
    }
    
    func dismissSelf(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
