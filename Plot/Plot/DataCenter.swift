//
//  DataCenter.swift
//  Plot
//
//  Created by Bo-Young PARK on 1/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class DataCenter {
    
    static let sharedData = DataCenter()
    
    var exhibitionData:[[String:Any]]?
    var userData:UserData?
    
    //전체 전시 데이터 가져오기
    func getExhibitionDatas(completion:@escaping (_ info:[[String:Any]]) -> Void) {
        Database.database().reference().child("ExhibitionData").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Any]] else {return}
            
            self.exhibitionData = json
            
            completion(json)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //특정 전시데이터 파싱하는 함수
    func requestExhibitionData(id:Int?, completion:@escaping (_ info:ExhibitionData) -> Void) {
        Database.database().reference().child("ExhibitionData").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //ExhibitionData 를 가져옵니다.
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let selectedExhibitionData:[String:Any] = json[realIntID]
            
            //JSON 형태의 ExhibitionData를 ExhibitionData_[String:Any] 구조체로 파싱
            let id:Int = selectedExhibitionData[Constants.exhibition_ID] as! Int
            let title:String = selectedExhibitionData[Constants.exhibition_Title] as! String
            let artist:String = selectedExhibitionData[Constants.exhibition_Artist] as! String
            let admission:Int = selectedExhibitionData[Constants.exhibition_Admission] as! Int
            let detail:String = selectedExhibitionData[Constants.exhibition_Detail] as! String
            let genre:String = selectedExhibitionData[Constants.exhibition_Genre] as! String
            let district:String = selectedExhibitionData[Constants.exhibition_District] as! String
            
            //-- Json 속의 Json 들 정리
            var imageURLs:[[String:Any]] = []
            var places:[[String:String]] = []
            var period:[[String:String]] = []
            var workingHours:[[String:String]] = []
            
            //-----imageURL Array
            guard let imgURLJSON = selectedExhibitionData[Constants.exhibition_ImgURL] as? [String:Any] else {return}
            
            let posterURL:String = imgURLJSON[Constants.image_PosterURL] as! String
            
            guard let detailURLJSON = imgURLJSON[Constants.image_DetailImages] as? [String] else {return}
            
            let detailURLs:[String] = detailURLJSON
            let imageDic:[String:Any] = [Constants.image_PosterURL:posterURL,
                                         Constants.image_DetailImages:detailURLs]
            imageURLs.append(imageDic)
            
            //-----place Array
            guard let placeJSON = selectedExhibitionData[Constants.exhibition_PlaceData] as? [String:String] else {return}
            
            let address:String = placeJSON[Constants.place_Address]!
            let websiteURL:String = placeJSON[Constants.place_WebsiteURL]!
            
            let placeDic:[String:String] = [Constants.place_Address:address,
                                            Constants.place_WebsiteURL:websiteURL]
            places.append(placeDic)
            
            //-----period Array
            guard let periodJSON = selectedExhibitionData[Constants.exhibition_Period] as? [String:String] else {return}
            
            let startDate:String = periodJSON[Constants.period_StartDate]!
            let endDate:String = periodJSON[Constants.period_EndDate]!
            
            let periodDic:[String:String] = [Constants.period_StartDate:startDate,
                                             Constants.period_EndDate:endDate]
            period.append(periodDic)
            
            //-----workingHour Array
            guard let workingHourJSON = selectedExhibitionData[Constants.exhibition_WorkingHours] as? [String:String] else {return}
            
            let startTime:String = workingHourJSON[Constants.workingHours_StartTime]!
            let endTime:String = workingHourJSON[Constants.workingHours_EndTime]!
            
            let workingHourDic:[String:String] = [Constants.workingHours_StartTime:startTime,
                                                  Constants.workingHours_EndTime:endTime]
            workingHours.append(workingHourDic)
            
            //모델링한 데이터들을 dictionary 형태로 묶어줍니다.
            let completeDic:[String:Any] = [Constants.exhibition_ID:id,
                                            Constants.exhibition_Title:title,
                                            Constants.exhibition_Artist:artist,
                                            Constants.exhibition_Admission:admission,
                                            Constants.exhibition_Detail:detail,
                                            Constants.exhibition_Genre:genre,
                                            Constants.exhibition_District:district,
                                            Constants.exhibition_PlaceData:places,
                                            Constants.exhibition_ImgURL:imageURLs,
                                            Constants.exhibition_Period:period,
                                            Constants.exhibition_WorkingHours:workingHours]
            
            completion(ExhibitionData.init(data: completeDic))
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    //유저데이터 파싱하는 함수
    func requestUserData(id:Int?, completion:@escaping (_ info:UserData) -> Void) {
        Database.database().reference().child("UserData").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //UserData를 가져옵니다.
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let selectedUserData:[String:Any] = json[realIntID]
            
            completion(UserData.init(dictionary: selectedUserData))
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //코멘트 파싱함수
    func requestCommentData(id:Int?, completion:@escaping (_ info:Comment) -> Void) {
        Database.database().reference().child("Comments").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let selectedCommentData:[String:Any] = json[realIntID]
            
            completion(Comment.init(data: selectedCommentData))
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //별점 파싱함수
    func requestStarPoint(id:Int?, completion:@escaping (_ info:StarPoint) -> Void) {
        Database.database().reference().child("StarPoints").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let selectedStarPointData:[String:Any] = json[realIntID]
            
            completion(StarPoint.init(data: selectedStarPointData))
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //좋아요 파싱함수
    func requestLike(id:Int?, completion:@escaping (_ info:Like) -> Void) {
        Database.database().reference().child("Likes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [[String:Int]],
                let realIntID:Int = id else {return}
            
            let selectedLikeData:[String:Int] = json[realIntID]
            
            completion(Like.init(data: selectedLikeData))
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //--특정 유저가 좋아요한 전시ID Array
    func requestFavoriteExhibitionIDsOfUser(id:Int?, completion:@escaping (_ info:[Int]) -> Void) {
        
        //좋아요 데이터를 가져옵니다
        Database.database().reference().child("Likes").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Int]],
                let realIntID:Int = id else {return}
            
            //가져온 좋아요 데이터 중, 입력한 UserID에 해당하는 좋아요 데이터만 필터합니다
            let likesDataForSelectedUser = json.filter({ (dic:[String:Int]) -> Bool in
                dic[Constants.likes_UserID] == realIntID
                
            })
            
            //필터링한 데이터 중, 전시ID 만 추출하여 어레이로 매핑합니다
            let favoriteExhibitionIDs = likesDataForSelectedUser.map({ (dic:[String:Int]) -> Int in
                return dic[Constants.likes_ExhibitionID]!
            })
            
            completion(favoriteExhibitionIDs)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //--특정 유저가 별점 남긴 전시ID Array
    func requestStarPointedExhibitionIDsOfUser(id:Int?, completion:@escaping (_ info:[Int]) -> Void) {
        
        Database.database().reference().child("StarPoints").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let starPointDataForSelectedUser = json.filter({ (dic:[String:Any]) -> Bool in
                let userID:Int = dic[Constants.starPoint_UserID] as! Int
                return realIntID == userID
                
            })
            
            let starPointedExhibitionIDs = starPointDataForSelectedUser.map({ (dic:[String:Any]) -> Int in
                return dic[Constants.starPoint_UserID] as! Int
            })
            
            completion(starPointedExhibitionIDs)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //--특정 유저의 코멘트 남긴 전시 ID Array
    func requestCommentedExhibitionIDsOfUser(id:Int?, completion:@escaping (_ info:[Int]) -> Void) {
        
        Database.database().reference().child("Comments").observe(.value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let commentDataForSelectedUser = json.filter({ (dic:[String:Any]) -> Bool in
                let userID:Int = dic[Constants.comment_UserID] as! Int
                return realIntID == userID
                
            })
            
            let commentedExhibitionIDs = commentDataForSelectedUser.map({ (dic:[String:Any]) -> Int in
                return dic[Constants.comment_UserID] as! Int
            })
            
            completion(commentedExhibitionIDs)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //--특정 전시의 별점 평균
    func requestAverageStarPointOfExhibition(id:Int?, completion:@escaping (_ info:Double) -> Void) {
        
        Database.database().reference().child("StarPoints").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let starPointDataForSelectedUser = json.filter({ (dic:[String:Any]) -> Bool in
                let userID:Int = dic[Constants.starPoint_ExhibitionID] as! Int
                return realIntID == userID
                
            })
            
            let starPoints = starPointDataForSelectedUser.map({ (dic:[String:Any]) -> Double in
                return dic[Constants.starPoint_Point] as! Double
            })
            let sumStarPoint = starPoints.reduce(0, { (point1, point2) -> Double in
                point1 + point2
            })
            let averageStarPoint:Double = sumStarPoint/Double(starPoints.count)
            
            completion(averageStarPoint)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //--특정 전시의 좋아요 합계
    func requestLikeCountsOfExhibition(id:Int?, completion:@escaping (_ info:Int) -> Void) {
        
        Database.database().reference().child("Likes").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Int]],
                let realIntID:Int = id else {return}
            
            let likesDataForSelectedExhibition = json.filter({ (dic:[String:Int]) -> Bool in
                dic[Constants.likes_ExhibitionID] == realIntID
                
            })
            
            let likesCount:Int = likesDataForSelectedExhibition.count
            
            completion(likesCount)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //--특정 전시의 코멘트 확인
    func requestCommentDetailOfExhibition(id:Int?, completion:@escaping (_ info:[String]) -> Void) {
        
        Database.database().reference().child("Comments").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [[String:Any]],
                let realIntID:Int = id else {return}
            
            let commentDataForSelectedExhibition = json.filter({ (dic:[String:Any]) -> Bool in
                let userID:Int = dic[Constants.comment_ExhibitionID] as! Int
                return realIntID == userID
            })
            
            let commentDetails = commentDataForSelectedExhibition.map({ (dic:[String:Any]) -> String in
                return dic[Constants.comment_Detail] as! String
                
            })
            
            completion(commentDetails)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}
