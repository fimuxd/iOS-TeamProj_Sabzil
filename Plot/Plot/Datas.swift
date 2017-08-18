//
//  Datas.swift
//  Plot
//
//  Created by Bo-Young PARK on 1/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import Foundation

//-----UserData
struct UserData {
    let id:String                             //기본적으로 부여되는 ID 값 (로그인아이디 아님)
    let email:String                       //이메일
    let password:String                    //비밀번호
    let profileImgURL:String               //프로필사진 URL
    let name:String                        //유저명
    
    var dictionary:[String:Any] {
        get{
            
            return [Constants.user_ID:self.id,
                    Constants.user_Email:self.email,
                    Constants.user_Password:self.password,
                    Constants.user_ProfileImgURL:self.profileImgURL,
                    Constants.user_Name:self.name,
            ]
        }
    }
    
    //init 할 부분
    init(dictionary:[String:Any]) {
        self.id = dictionary[Constants.user_ID] as! String
        self.email = dictionary[Constants.user_Email] as! String
        self.password = dictionary[Constants.user_Password] as! String
        self.profileImgURL = dictionary[Constants.user_ProfileImgURL] as! String
        self.name = dictionary[Constants.user_Name] as! String
        
    }
}


struct StarPoint {
    let id:Int                              //기본적으로 부여되는 ID 값
    let exhibitionID:Int                    //별점을 받은 전시ID
    let userID:String                       //별점을 준 유저ID
    let point:Point                         //별점
    
    var dictionary:[String:Any] {
        return [Constants.starPoint_ID:self.id,
                Constants.starPoint_ExhibitionID:self.exhibitionID,
                Constants.starPoint_UserID:self.userID,
                Constants.starPoint_Point:self.point]
    }
    
    init(data:[String:Any]) {
        self.id = data[Constants.starPoint_ID] as! Int
        self.exhibitionID = data[Constants.starPoint_ExhibitionID] as! Int
        self.userID = data[Constants.starPoint_UserID] as! String
        self.point = Point.init(rawValue: data[Constants.starPoint_Point] as! Double)!
    }
}

struct Comment {
    let id:Int                              //기본적으로 부여되는 ID 값
    let exhibitionID:Int                    //어떤 전시에 대한 후기인지 전시의 ID 값 저장
    let userID:String                       //어떤 유저가 남긴 후기인지 유저의 ID 값 저장
    let detail:String                       //후기
    
    var dictionary:[String:Any] {
        return [Constants.comment_ID:self.id,
                Constants.comment_ExhibitionID:self.exhibitionID,
                Constants.comment_UserID:self.userID,
                Constants.comment_Detail:self.detail]
    }
    
    init(data:[String:Any]) {
        self.id = data[Constants.comment_ID] as! Int
        self.exhibitionID = data[Constants.comment_ExhibitionID] as! Int
        self.userID = data[Constants.comment_UserID] as! String
        self.detail = data[Constants.comment_Detail] as! String
    }
}

enum Point:Double {
    case FiveStar = 5
    case FourPointFiveStar = 4.5
    case FourStar = 4
    case ThreePointFiveStar = 3.5
    case ThreeStar = 3
    case TwoPointFiveStar = 2.5
    case TwoStar = 2
    case OnePointFiveStar = 1.5
    case OneStar = 1
    case HalfStar = 0.5
    case Zero = 0
}


//-----ExhibitionData
struct ExhibitionData {
    let id:Int                          //기본적으로 부여되는 ID 값
    let title:String                    //전시제목
    let artist:String                   //전시주체(작가/단체)
    let admission:Int                   //관람료
    let detail:String                   //작품설명
    let genre:Genre                     //장르
    let district:District               //전시지역
    var placeData:[Place]               //전시장소
    var imgURL:[Image]                  //전시이미지
    var periodData:[Period]             //전시기간
    var workingHourData:[WorkingHours]  //관람시간
    
    var dictionary:[String:Any] {
        get{
            var tempPlaceData:[[String:String]] = []
            var tempImageData:[[String:Any]] = []
            var tempPeriodData:[[String:String]] = []
            var tempWorkingHourData:[[String:String]] = []
            
            //            placeData.forEach { (place) in
            //              tempImageData.append(place.dictionary)
            //            }
            
            for place in placeData {
                tempPlaceData.append(place.dictionary)
            }
            
            for image in imgURL {
                tempImageData.append(image.dictionary)
            }
            
            for period in periodData {
                tempPeriodData.append(period.dictionary)
            }
            for workinghour in workingHourData {
                tempWorkingHourData.append(workinghour.dictionary)
            }
            
            return [Constants.exhibition_ID:self.id,
                    Constants.exhibition_Title:self.title,
                    Constants.exhibition_Artist:self.artist,
                    Constants.exhibition_Admission:self.admission,
                    Constants.exhibition_Detail:self.detail,
                    Constants.exhibition_Genre:self.genre,
                    Constants.exhibition_District:self.district,
                    Constants.exhibition_PlaceData:tempPlaceData,
                    Constants.exhibition_ImgURL:tempImageData,
                    Constants.exhibition_Period:tempPeriodData,
                    Constants.exhibition_WorkingHours:tempWorkingHourData]
        }
    }
    
    init(data:[String:Any]) {
        self.id = data[Constants.exhibition_ID] as! Int
        self.title = data[Constants.exhibition_Title] as! String
        self.artist = data[Constants.exhibition_Artist] as! String
        self.admission = data[Constants.exhibition_Admission] as! Int
        self.detail = data[Constants.exhibition_Detail] as! String
        self.genre = Genre(rawValue: data[Constants.exhibition_Genre] as! String)!
        self.district = District(rawValue: data[Constants.exhibition_District] as! String)!
        self.placeData = []
        self.imgURL = []
        self.periodData = []
        self.workingHourData = []
        
        if let tempPlaceData:[[String:String]] = data[Constants.exhibition_PlaceData] as? [[String:String]],
            let tempImageData:[[String:Any]] = data[Constants.exhibition_ImgURL] as? [[String:Any]],
            let tempPeriodData:[[String:String]] = data[Constants.exhibition_Period] as? [[String:String]],
            let tempWorkingHourData:[[String:String]] = data[Constants.exhibition_WorkingHours] as? [[String:String]] {
            
            for place in tempPlaceData {
                placeData.append(Place.init(data: place))
            }
            for image in tempImageData {
                imgURL.append(Image.init(data: image))
            }
            for period in tempPeriodData {
                periodData.append(Period.init(data: period))
            }
            for workingHour in tempWorkingHourData {
                workingHourData.append(WorkingHours.init(data: workingHour))
            }
        }
    }
}

struct Place {
    // TODO: 강사님께 물어볼 것 - 옵셔널 바인딩 솔직히 어디다가 박아야 할 지 모르겠다.
    //    var address:String?                          //전시장소 주소
    //    var websiteURL:String?                       //전시관련 Website
    //
    //    var dictionary:[String:String] {
    //        guard let address = self.address,
    //            let websiteURL = self.websiteURL else {return [:]}
    //        return [Constants.place_Address:address,
    //                Constants.place_WebsiteURL:websiteURL]
    //    }
    //
    //    init(data:[String:String]) {
    //        self.address = data[Constants.place_Address] ?? "주소가 없습니다"
    //        self.websiteURL = data[Constants.place_WebsiteURL] ?? "웹사이트가 없습니다"
    //    }
    
    var address:String
    var websiteURL:String
    
    var dictionary:[String:String] {
        return [Constants.place_Address:self.address,
                Constants.place_WebsiteURL:self.websiteURL]
    }
    
    init(data:[String:String]) {
        self.address = data[Constants.place_Address]!
        self.websiteURL = data[Constants.place_WebsiteURL]!
    }
}

struct Image {
    let posterURL:String                         //메인포스터
    let detailImages:[String]                    //디테일포스터 Array
    
    var dictionary:[String:Any] {
        
        var tempData:[String] = []
        
        for string in detailImages {
            tempData.append("")
        }
        
        return [Constants.image_PosterURL:self.posterURL,
                Constants.image_DetailImages:tempData]
    }
    
    init(data:[String:Any]) {
        self.posterURL = data[Constants.image_PosterURL] as! String
        self.detailImages = data[Constants.image_DetailImages] as! [String]
    }
}

struct Period {
    let startDate:String
    let endDate:String
    
    var dictionary:[String:String] {
        return [Constants.period_StartDate:self.startDate,
                Constants.period_EndDate:self.endDate]
    }
    
    init(data:[String:String]) {
        self.startDate = data[Constants.period_StartDate]!
        self.endDate = data[Constants.period_EndDate]!
    }
}

struct WorkingHours {
    let startTime:String
    let endTime:String
    
    var dictionary:[String:String] {
        return [Constants.workingHours_StartTime:self.startTime,
                Constants.workingHours_EndTime:self.endTime]
    }
    
    init(data:[String:String]) {
        self.startTime = data[Constants.workingHours_StartTime]!
        self.endTime = data[Constants.workingHours_EndTime]!
    }
}

struct Like {
    let id:Int
    let exhibitionID:Int
    let userID:String
    
    var dictionary:[String:Any] {
        return [Constants.likes_ID:id,
                Constants.likes_ExhibitionID:exhibitionID,
                Constants.likes_UserID:userID]
    }
    
    init(data:[String:Any]) {
        self.id = data[Constants.likes_ID] as! Int
        self.exhibitionID = data[Constants.likes_ExhibitionID] as! Int
        self.userID = data[Constants.likes_UserID] as! String
    }
}


enum Genre:String {
    case Paint = "미술"
    case Photo = "사진"
    case Video = "영상"
    case Craft = "공예"
    case Carving = "조각"
    case Installation = "설치"
    case Etc = "기타"
}

enum District:String {
    case Seoul = "서울"
    case Incheon = "인천"
    case DaeJeon = "대전"
    case DaeGu = "대구"
    case UlSan = "울산"
    case GwangJu = "광주"
    case Busan = "부산"
    case GyeongGi = "경기"
    case GangWon = "강원"
    case ChungCheongNam = "충남"
    case ChuncCehongBuk = "충북"
    case GyeongSangNam = "경남"
    case GyeongSangBuk = "경북"
    case JeonLaNam = "전남"
    case JeonLaBuk = "전북"
    case JeJu = "제주"
}

//enum District {
//    case Seoul
//    case Incheon
//    case DaeJeon
//    case DaeGu
//    case UlSan
//    case GwangJu
//    case Busan
//    case GyeongGi
//    case GangWon
//    case ChungCheongNam
//    case ChuncCehongBuk
//    case GyeongSangNam
//    case GyeongSangBuk
//    case JeonLaNam
//    case JeonLaBuk
//    case JeJu
//}
