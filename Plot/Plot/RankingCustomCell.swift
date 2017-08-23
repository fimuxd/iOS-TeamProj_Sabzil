//
//  RankingCustomCell.swift
//  Plot
//
//  Created by joe on 2017. 8. 4..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class RankingCustomCell: UICollectionViewCell {

    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    //-----지역별 전시를 가져옵니다.
    func getExhibitionData(OfDistrict:District, itemOfIndexPath:Int) {
        
//        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_District).queryEqual(toValue: OfDistrict.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if OfDistrict == District.Seoul {
                guard let json = snapshot.value as? [Any] else {return}
                
                let filteredJson = json.filter({ (value) -> Bool in
                    return !(value is NSNull)
                })
                
                guard let realJson = filteredJson as? [[String:Any]] else {return}
//                DispatchQueue.main.async {
                    guard let imageDic:[String:Any] = realJson[itemOfIndexPath][Constants.exhibition_ImgURL] as? [String:Any],
                        let posterImgURL:String = imageDic[Constants.image_PosterURL] as? String else {return}
                    
                    guard let url = URL(string: posterImgURL) else {return}
                    do{
                        let realData = try Data(contentsOf: url)
                        self.posterImage.image = UIImage(data: realData)
                    }catch{
                        
                    }
//                    }
                }else{
                    guard let json = snapshot.value as? [String:[String:Any]] else {return}
                    
                    let mappedJson = json.map({ (dic:(key: String, value: [String : Any])) -> [String : Any] in
                        return dic.value
                    })
                    
//                    DispatchQueue.main.async {
                        guard let imageDic:[String:Any] = mappedJson[itemOfIndexPath][Constants.exhibition_ImgURL] as? [String:Any],
                            let posterImgURL:String = imageDic[Constants.image_PosterURL] as? String else {return}
                        
                        guard let url = URL(string: posterImgURL) else {return}
                        do{
                            let realData = try Data(contentsOf: url)
                            self.posterImage.image = UIImage(data: realData)
                        }catch{
                            
                        }
                    }
//                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
//    }
    
    //-----장르별 전시를 가져옵니다.
    func getExhibitionData(OfGenre:Genre, itemOfIndexPath:Int) {
        
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_Genre).queryEqual(toValue: OfGenre.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let json = snapshot.value as? [String:[String:Any]] else {return}
                    
                    let mappedJson = json.map({ (dic:(key: String, value: [String : Any])) -> [String : Any] in
                        return dic.value
                    })
                    
                
                        guard let imageDic:[String:Any] = mappedJson[itemOfIndexPath][Constants.exhibition_ImgURL] as? [String:Any],
                            let posterImgURL:String = imageDic[Constants.image_PosterURL] as? String else {return}

                        guard let url = URL(string: posterImgURL) else {return}
                        do{
                            let realData = try Data(contentsOf: url)
                            DispatchQueue.main.async {
                            self.posterImage.image = UIImage(data: realData)
                            }
                        }catch{
                            
                        }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    }
    
    /*************** 아직 구현 못함****************/
    //랭킹
    //-----좋아요를 많이 받은 전시데이터를 가져옵니다.
    func getPopularExhibitionData() {
        
        /* 알고리즘 문제. ottokaji?
         Database.database().reference().child("Likes").observeSingleEvent(of: .value, with: { (snapshot) in
         guard let json = snapshot.value as? [String:[String:Any]] else {return}
         
         let mappedJson = json.map({ (dic:(key: String, value: [String : Any])) -> [String:Any] in
         return dic.value
         })
         
         let exhibitionIDs = mappedJson.map({ (dic) -> Int in
         guard let exhibitionID:Int = dic[Constants.likes_ExhibitionID] as? Int else {return 100}
         return exhibitionID
         })
         
         print(exhibitionIDs.sorted())
         
         }) { (error) in
         print(error.localizedDescription)
         }
         */
        
    }
    
    //-----코멘트가 많은 전시를 가져옵니다.
    func getMostCommentedExhibitionData() {
        
    }

}
