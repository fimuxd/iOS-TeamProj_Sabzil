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
        
        let ref = Database.database().reference().child("ExhibitionData").child(id)
        
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //ExhibitionData 를 가져옵니다.
            guard let json = snapshot.value as? [String:Any] else {return}
            
            //            print(selectedExhibitionJson)
            
            //JSON 형태의 ExhibitionData를 ExhibitionData_[String:Any] 구조체로 파싱
            
            let id:Int = json[Constants.exhibition_ID] as! Int
            let title:String = json[Constants.exhibition_Title] as! String
            let artist:String = json[Constants.exhibition_Artist] as! String
            let admission:Int = json[Constants.exhibition_Admission] as! Int
            let detail:String = json[Constants.exhibition_Detail] as! String
            let genre:Genre = Genre(rawValue: json[Constants.exhibition_Genre] as! String)!
            let district:District = District(rawValue: json[Constants.exhibition_District] as! String)!
            var imageURLs:[Image] = []
            var places:[Place] = []
            var period:[Period] = []
            var workingHours:[WorkingHours] = []
            
            
            //-----imageURL Array
            let imgURLSnapshot = snapshot.childSnapshot(forPath: Constants.exhibition_ImgURL)
            guard let imgURLJSON = imgURLSnapshot.value as? [String:Any] else {return}
            
            let posterURL:String = imgURLJSON[Constants.image_PosterURL] as! String
            let detailURLSnapshot = imgURLSnapshot.childSnapshot(forPath: Constants.image_DetailImages)
            
            guard let detailURLJSON = detailURLSnapshot.value as? [String] else {return}
            
            let detailURLs:[String] = detailURLJSON
            let imageDic:[String:Any] = [Constants.image_PosterURL:posterURL,
                                         Constants.image_DetailImages:detailURLs]
            let imageData:Image = Image(data: imageDic)
            imageURLs.append(imageData)
            
            //-----place Array
            let placeSnapshot = snapshot.childSnapshot(forPath: Constants.exhibition_PlaceData)
            guard let placeJSON = placeSnapshot.value as? [String:String] else {return}
            
            let address:String = placeJSON[Constants.place_Address] as! String
            let websiteURL:String = placeJSON[Constants.place_WebsiteURL] as! String
            
            let placeDic:[String:String] = [Constants.place_Address:address,
                                            Constants.place_WebsiteURL:websiteURL]
            let placeData:Place = Place(data: placeDic)
            places.append(placeData)
            
            //-----period Array
            let periodSnapshot = snapshot.childSnapshot(forPath: Constants.exhibition_Period)
            guard let periodJSON = periodSnapshot.value as? [String:String] else {return}
            
            let startDate:String = periodJSON[Constants.period_StartDate] as! String
            let endDate:String = periodJSON[Constants.period_EndDate] as! String
            
            let periodDic:[String:String] = [Constants.period_StartDate:startDate,
                                             Constants.period_EndDate:endDate]
            let periodData:Period = Period(data: periodDic)
            period.append(periodData)
            
            //-----workingHour Array
            let workingHourSnapshot = snapshot.childSnapshot(forPath: Constants.exhibition_WorkingHours)
            guard let workingHourJSON = workingHourSnapshot.value as? [String:String] else {return}
            
            let startTime:String = workingHourJSON[Constants.workingHours_StartTime] as! String
            let endTime:String = workingHourJSON[Constants.workingHours_EndTime] as! String
            
            let workingHourDic:[String:String] = [Constants.workingHours_StartTime:startTime,
                                                  Constants.workingHours_EndTime:endTime]
            let workingHourData:WorkingHours = WorkingHours(data: workingHourDic)
            workingHours.append(workingHourData)
            
            print(" id:\(id)\n 전시제목:\(title)\n 작가(주최자):\(artist)\n 관람료:\(admission)\n 설명:\(detail)\n 장르:\(genre)\n 지역:\(district)\n 이미지주소:\(imageURLs)\n 장소주소:\(places)\n 전시기간:\(period)\n 관람시간:\(workingHours)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        /*
         for place in tempPlaceData {
         placeData.append(Place.init(data: place))
         }
         for period in tempPeriodData {
         periodData.append(Period.init(data: period))
         }
         for workingHour in tempWorkingHourData {
         workingHourData.append(WorkingHours.init(data: workingHour))
         }
         */
        
        
        
    }
}
