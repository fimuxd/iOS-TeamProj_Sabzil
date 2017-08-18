//
//  Popup.swift
//  Plot
//
//  Created by joe on 2017. 8. 8..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class Popup: UIViewController, UITextViewDelegate {
    
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
        self.view.endEditing(true)
        presentStarPointPopup()
    }
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var commentView: UIView!
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        commentPopupConstraint.constant = -300
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Popkeyboard), name: NSNotification.Name("dismissStarPopup"), object: nil)
        
        self.commentTextView.delegate = self
        self.commentTextView.isScrollEnabled = false
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.commentTextView.text == "이 작품에 대한 생각을 자유롭게 표현해주세요." {
            self.commentTextView.text = ""
        }
        commentPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
    }
    
    func Popkeyboard(){
        self.commentTextView.becomeFirstResponder()
    }
    
}
