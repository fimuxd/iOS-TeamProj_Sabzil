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
    
    //    var databaseReference:DatabaseReference
    var exhibitionData:ExhibitionData?
    var userData:UserData?
    
    
    //    var isLogin:Bool = false
    //    var userData:UserData?
    //    private func requestIsLogin() -> Bool {
    //        if Auth.auth().currentUser == nil {
    //            isLogin = false
    //            return false
    //        }else{
    //            isLogin = true
    //            return true
    //        }
    //    }
    //
    //    private func requestUserData(completion:@escaping (_ info:UserData) -> Void) {
    //        guard let uid = Auth.auth().currentUser?.uid else {return}
    //
    //        Database.database().reference().child(uid).observeSingleEvent(of: .value, with: { (snapShot) in
    //            let dic = snapShot.value as! [String:Any]
    //            completion(UserData.init(dictionary: dic))
    //        })
    //    }
    
    func getExhibitionData(id:String) {
        
        Database.database().reference().child("ExhibitionData").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            //ExhibitionData 를 가져옵니다.
            guard let selectedExhibitionJson = snapshot.value as? [String:Any] else {return}
            
//            print(selectedExhibitionJson)
            
            //JSON 형태의 ExhibitionData를 ExhibitionData_[String:Any] 구조체로 파싱
            
            let id:Int = selectedExhibitionJson[Constants.exhibition_ID] as! Int
            let title:String = selectedExhibitionJson[Constants.exhibition_Title] as! String
            let artist:String = selectedExhibitionJson[Constants.exhibition_Artist] as! String
            let admission:Int = selectedExhibitionJson[Constants.exhibition_Admission] as! Int
            let detail:String = selectedExhibitionJson[Constants.exhibition_Detail] as! String
            let likesFromUser:Int = selectedExhibitionJson[Constants.exhibition_LikesFromUser] as! Int
            let starPointFromUser:Int = selectedExhibitionJson[Constants.exhibition_StarPointFromUser] as! Int
            let genre:Genre = Genre(rawValue: selectedExhibitionJson[Constants.exhibition_Genre] as! String)!
            let district:District = District(rawValue: selectedExhibitionJson[Constants.exhibition_District] as! String)!
            var placeData:[Place] = []
            var imgURL:[Image] = []
            var commentsFromUser:[Comment] = []
            var periodData:[Period] = []
            var workingHourData:[WorkingHours] = []
            
            guard let tempPlaceData:[[String:String]] = selectedExhibitionJson[Constants.exhibition_PlaceData] as? [[String:String]],
                let tempImageData:[[String:Any]] = selectedExhibitionJson[Constants.exhibition_ImgURL] as? [[String:Any]],
                let tempCommentsData:[[String:Any]] = selectedExhibitionJson[Constants.exhibition_CommentsFromUser] as? [[String:Any]],
                let tempPeriodData:[[String:String]] = selectedExhibitionJson[Constants.exhibition_Period] as? [[String:String]],
                let tempWorkingHourData:[[String:String]] = selectedExhibitionJson[Constants.exhibition_WorkingHours] as? [[String:String]] else {return}
            
            for place in tempPlaceData {
                placeData.append(Place.init(data: place))
            }
            for image in tempImageData {
                imgURL.append(Image.init(data: image))
            }
            for comment in tempCommentsData {
                commentsFromUser.append(Comment.init(data: comment))
            }
            for period in tempPeriodData {
                periodData.append(Period.init(data: period))
            }
            for workingHour in tempWorkingHourData {
                workingHourData.append(WorkingHours.init(data: workingHour))
            }
            
            
//            var dataFromJSON:[String:Any] = [Constants.]
            
        
    }) { (error) in
    print(error.localizedDescription)
    }
    
    
    
    
    
    
}
}

