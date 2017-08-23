//
//  Popup.swift
//  Plot
//
//  Created by joe on 2017. 8. 8..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class Popup: UIViewController, UITextViewDelegate {
    
    var exhibitionID:Int?
    var userCommentData:[(key: String, value: [String : Any])] = []
    
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
    
        if self.commentTextView.text != "" && self.userCommentData.count == 0 {
            Database.database().reference().child("Comments").childByAutoId().setValue([Constants.comment_Detail:self.commentTextView.text,
                                                                                        Constants.comment_UserID:Auth.auth().currentUser?.uid,
                                                                                        Constants.comment_ExhibitionID:self.exhibitionID!])
        }else if self.commentTextView.text != "" && self.userCommentData.count != 0 {
            Database.database().reference().child("Comments").child(self.userCommentData[0].key).setValue([Constants.comment_Detail:self.commentTextView.text,
                                                                                                           Constants.comment_UserID:Auth.auth().currentUser?.uid,
                                                                                                           Constants.comment_ExhibitionID:self.exhibitionID!])
        }
        
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
        
        if self.userCommentData.count != 0 {
            let commentDetail:String = self.userCommentData[0].value[Constants.comment_Detail] as! String
            self.commentTextView.text = commentDetail
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Popkeyboard), name: NSNotification.Name("dismissStarPopup"), object: nil)
        
        self.commentTextView.delegate = self
        self.commentTextView.isScrollEnabled = false
        
        //코멘트 데이터
        Database.database().reference().child("Comments").keepSynced(true)
        
        print(self.exhibitionID)
        
//        DataCenter.sharedData.requestCommentDataFor(exhibitionID: self.exhibitionID!, userID: Auth.auth().currentUser?.uid) { (data) in
//            self.userCommentData = data
//        }
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
