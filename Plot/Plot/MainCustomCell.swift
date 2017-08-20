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

            
        }else{
            self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
            
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
        
        //좋아요

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    
}
