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
    func reloadMainTableView()
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
        self.likeButtonAction()
    }
    
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func loadExbibitionData(rowOfIndexPath:Int) {
        DispatchQueue.global(qos: .default).async {
            
            Database.database().reference().child("ExhibitionData").child("\(rowOfIndexPath)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let json = snapshot.value as? [String:Any] else {return}
                
                DispatchQueue.main.async {
                    guard let titleStr:String = json[Constants.exhibition_Title] as? String else {return}
                    self.mainTitleLabel.text = titleStr
                    
                    guard let districStr:String = json[Constants.exhibition_District] as? String else {return}
                    self.localLabel.text = districStr
                    
                    guard let periodDic:[String:String] = json[Constants.exhibition_Period] as? [String:String],
                        let startDateStr:String = periodDic[Constants.period_StartDate],
                        let endDateStr:String = periodDic[Constants.period_EndDate] else {return}
                    self.exhibitionTerm.text = "\(startDateStr) ~ \(endDateStr)"
                    
                    guard let artistStr:String = json[Constants.exhibition_Artist] as? String else {return}
                    self.museumName.text = artistStr
                    
                    
                    guard let imageDic:[String:Any] = json[Constants.exhibition_ImgURL] as? [String:Any],
                        let posterImgURL:String = imageDic[Constants.image_PosterURL] as? String else {return}
                    
                    guard let url = URL(string: posterImgURL) else {return}
                    do{
                        let realData = try Data(contentsOf: url)
                        self.mainPosterImg.image = UIImage(data: realData)
                    }catch{
                        
                    }
                }
                print("===\(rowOfIndexPath)번 전시 제이슨로딩중===")
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
    }
    
    func loadLikeData(rowOfIndexPath:Int) {
        
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String:[String:Any]] else {return}
                
                let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                    var exhibitionID:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                    return exhibitionID == rowOfIndexPath
                })
                
                DispatchQueue.main.async {
                    switch filteredLikeData.count {
                    case 0:
                        self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
                    case 1:
                        self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
                    default:
                        print("좋아요 버튼표시에러: \(filteredLikeData)")
                    }
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
        
    }
    
    func likeButtonAction() {
        guard let realExhibitionID:Int = self.indexPathRow else {return}
        Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [String:[String:Any]] else {return}
            
            let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                var exhibitionID:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                return exhibitionID == realExhibitionID
            })
            
            switch filteredLikeData.count {
            case 0:
                self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
                Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:self.indexPathRow!,
                                                                                         Constants.likes_UserID:Auth.auth().currentUser?.uid])
            case 1:
                self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
                Database.database().reference().child("Likes").child(filteredLikeData[0].key).setValue(nil)
            default:
                print("좋아요 버튼액션에러: \(filteredLikeData)")
            }
            
        }, withCancel: { (error) in
            print(error.localizedDescription)
        })
        
        Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.childChanged, with: { (snapshot) in
            guard let json = snapshot.value as? [String:[String:Any]] else {return}
            
            let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                var exhibitionID:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                return exhibitionID == realExhibitionID
            })
            
            
            switch filteredLikeData.count {
            case 0:
                self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_on")
                Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:self.indexPathRow!,
                                                                                         Constants.likes_UserID:Auth.auth().currentUser?.uid])
            case 1:
                self.likeBtnOutlet.image = #imageLiteral(resourceName: "likeBtn_off")
                Database.database().reference().child("Likes").child(filteredLikeData[0].key).setValue(nil)
            default:
                print("좋아요 버튼액션에러: \(filteredLikeData)")
            }
            
        }, withCancel: { (error) in
            print(error.localizedDescription)
        })
 
    }
}
