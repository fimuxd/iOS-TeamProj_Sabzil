//
//  MainCustomCell.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

protocol customCellDelegate {
    func isCommentButtonClicked()
    func isStarPointButtonClicked()
    func isLikeButtonClicked()
}

class MainCustomCell: UITableViewCell {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    var delegate:customCellDelegate?
    
    var indexPathRow:Int?
    let likeDataRef = Database.database().reference().child("Likes")
    var favoriteExhibitionIDs:[Int] = []
    var likeDataCount:Int?

    
    @IBOutlet weak var mainPosterImg: UIImageView!
    @IBOutlet weak var scoreFirstStar: UIImageView!
    @IBOutlet weak var scoreSecondStar: UIImageView!
    @IBOutlet weak var scorethirdStar: UIImageView!
    @IBOutlet weak var scoreFourthStar: UIImageView!
    @IBOutlet weak var scoreFifthStar: UIImageView!
    
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var exhibitionTerm: UILabel!
    @IBOutlet weak var museumName: UILabel!
    
    @IBOutlet weak var likeBtnOutlet: UIImageView!
    @IBAction func clickedLikeBtn(_ sender: UIButton) {
        
        if self.likeBtnOutlet.image == #imageLiteral(resourceName: "likeBtn_on") {
            self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
            Database.database().reference().child("Likes").childByAutoId().setValue(nil)
        }else {
            self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
            Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:self.indexPathRow,
                                                                                     Constants.likes_UserID:Auth.auth().currentUser?.uid])
        }
        
        self.delegate?.isLikeButtonClicked()
        
        
    }
    
    @IBAction func clickedComentBtn(_ sender: UIButton) {
        self.delegate?.isCommentButtonClicked()
    }
    
    @IBAction func starPointBtnClicked(_ sender: UIButton) {
       self.delegate?.isStarPointButtonClicked()
    }
    @IBAction func likeBtnClicked(_ sender: UIButton) {
        self.delegate?.isLikeButtonClicked()
        
    }
  
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeDataRef.keepSynced(true)

        self.likeDataRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let likesJSON = snapshot.value as? [[String:Any]] else {return}
            
            print(likesJSON)
            var filteredJSON = likesJSON.filter({ (dic) -> Bool in
                let filteredUserID:String = dic[Constants.likes_UserID] as! String
                return filteredUserID == Auth.auth().currentUser?.uid
            })
            
            var mappedJSON = filteredJSON.map({ (dic:[String:Any]) -> Int in
                return dic[Constants.likes_ExhibitionID] as! Int
            })
            
            self.favoriteExhibitionIDs = mappedJSON
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    
}
