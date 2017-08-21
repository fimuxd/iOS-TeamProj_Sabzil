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
    
    @IBAction func clickedComentBtn(_ sender: UIButton) {
        self.delegate?.isCommentButtonClicked()
    }
    
    @IBAction func starPointBtnClicked(_ sender: UIButton) {
        self.delegate?.isStarPointButtonClicked()
    }
    
    @IBAction func likeBtnClicked(_ sender: UIButton) {
        
        
        /*
        var userLikesData:[(key: String, value: [String : Any])]? {
            didSet{
                
                guard let realLikeData = userLikesData else {return}
                
                if self.likeBtnOutlet.image == #imageLiteral(resourceName: "likeBtn_on") {
                    self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
                    
                    if realLikeData.count != 0 {
                        let keyString:String = realLikeData[0].key
                        Database.database().reference().child("Likes").child(keyString).setValue(nil)
                    }
                }else{
                    self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
                    
                    if realLikeData.count == 0 {
                        Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:self.indexPathRow!,
                                                                                                 Constants.likes_UserID:Auth.auth().currentUser?.uid])
                    }
                }
                self.delegate?.isLikeButtonClicked()
            }
        }
        
        Database.database().reference().child("Likes").keepSynced(true)
        DataCenter.sharedData.requestLikeDataFor(exhibitionID: self.indexPathRow!, userID: Auth.auth().currentUser?.uid) { (data) in
            userLikesData = data
        }
        */
        
        
    }
    
    func loadData(RowOfIndexPath:Int) {
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("ExhibitionData").child("\(RowOfIndexPath)").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String:Any] else {return}
                
                DispatchQueue.main.async {
                    self.mainTitleLabel.text = json[Constants.exhibition_Title] as! String
                    self.localLabel.text = json[Constants.exhibition_District] as! String
                    
                    let periodDic:[String:String] = json[Constants.exhibition_Period] as! [String:String]
                    let startDateStr:String = periodDic[Constants.period_StartDate] as! String
                    let endDateStr:String = periodDic[Constants.period_EndDate] as! String
                    self.exhibitionTerm.text = "\(startDateStr) ~ \(endDateStr)"
                    
                    self.museumName.text = json[Constants.exhibition_Artist] as! String

                    let imageDic:[String:Any] = json[Constants.exhibition_ImgURL] as! [String:Any]
                    let posterImgURL:String = imageDic[Constants.image_PosterURL] as! String
                    guard let url = URL(string: posterImgURL) else {return}
                    do{
                        let realData = try Data(contentsOf: url)
                        self.mainPosterImg.image = UIImage(data: realData)
                    }catch{
                        
                    }
                }
                print("===\(RowOfIndexPath)번 전시 제이슨로딩중===")
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
            
            Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_ExhibitionID).queryEqual(toValue: RowOfIndexPath).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let filteredJSON = snapshot.value as? [String:[String : Any]] else {
                    print("좋아요 없어여")
                    return
                }
                
                let filteredDic = filteredJSON.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                    let userIDValue:String = dic.value[Constants.likes_UserID] as! String
                    return userIDValue == Auth.auth().currentUser?.uid
                })
                
                DispatchQueue.main.async {
                    if filteredDic.count != 0 {
                        let exhibitionID:Int = filteredDic[0].value[Constants.likes_ExhibitionID] as! Int
                        if exhibitionID == RowOfIndexPath {
                            self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
                        }
                    }else{
                        self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
                    }
                }
            }){ (error) in
                print(error.localizedDescription)
            }

        }
        
        
    }
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Database.database().reference().child("Likes").keepSynced(true)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    
}
