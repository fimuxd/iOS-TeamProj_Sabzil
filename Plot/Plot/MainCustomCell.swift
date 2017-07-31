//
//  MainCustomCell.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class MainCustomCell: UITableViewCell {
    
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
        
    }
    
    @IBAction func clickedComentBtn(_ sender: UIButton) {
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        localLabel.text = "서울"
        mainTitleLabel.text = "메인타이틀 텍스트 전시이름이들어갑니다"
        exhibitionTerm.text = "2017. 07. 08~ 2017. 08. 09"
        museumName.text = "디뮤지엄"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
