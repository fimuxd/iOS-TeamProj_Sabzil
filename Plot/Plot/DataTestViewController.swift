//
//  DataTestViewController.swift
//  Plot
//
//  Created by Bo-Young PARK on 7/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import UIKit
import Firebase

class DataTestViewController: UIViewController {
    
    
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func searchButtonAction(_ sender: UIButton) {
        print("전시검색 버튼이 눌렸습니다")
        DataCenter.sharedData.requestExhibitionData(id: Int(self.inputTextField.text!)!, completion: {(exhibition) in
            self.exhibitionData = exhibition
        })
    }
    
    @IBOutlet weak var inputUserIDTextField: UITextField!
    @IBAction func searchUserButtonAction(_ sender: UIButton) {
        print("유저검색 버튼이 눌렸습니다")
        DataCenter.sharedData.requestUserData(id: Int(self.inputUserIDTextField.text!)!) { (user) in
            self.userData = user
        }
    }
    
    var exhibitionData:ExhibitionData?{
        didSet{
//            print("전시데이터: \(exhibitionData)/n==================================")
            
            guard let url = URL(string: (exhibitionData?.imgURL[0].posterURL)!) else {return}
            
            do{
                let realData = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: realData)
                print("loading Image")
            }catch{
                
            }
        }
    }
    
    var userData:UserData?{
        didSet{
//            print("유저데이터: \(userData)/n==================================")
            
            guard let url = URL(string: (userData?.profileImgURL)!) else {return}
            
            do{
                let realData = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: realData)
                print("loading Image")
            }catch{
                
            }
        }
        
    }
    
    
    var commentData:Comment?{
        didSet{
//            print("코멘트: \(commentData)")
        }
    }
    
    var likeData:Like?{
        didSet{
//            print("좋아요: \(likeData)")
        }
    }
    
    var starPointData:StarPoint?{
        didSet{
//            print("별점: \(starPointData)")
        }
    }
    
    var testArray:Int?{
        didSet{
            print("여기:\(testArray)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataCenter.sharedData.requestCommentData(id: 0) { (comment) in
            self.commentData = comment
        }
        DataCenter.sharedData.requestLike(id: 0) { (like) in
            self.likeData = like
        }
        DataCenter.sharedData.requestStarPoint(id: 0) { (star) in
            self.starPointData = star
        }
        
        DataCenter.sharedData.requestLikeCountsOfExhibition(id: 0) { (int) in
            self.testArray = int
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
