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
    let id:Int                             //기본적으로 부여되는 ID 값 (로그인아이디 아님)
    let email:String                       //이메일
    let password:String                    //비밀번호
    let profileImgURL:String               //프로필사진 URL
    let name:String                        //유저명
    var likesExhibitions:[Int]             //좋아요; Exhibition의 ID값을 Array로 저장
    var starPoints:[StarPoint]             //별점
    var comments:[Comment]                 //후기
    
    var dictionary:[String:Any] {
        get{
            //likesExhibitions 채워놓을 곳
            var tempLikesExhibitions:[Int] = []
            for exhibitionID in likesExhibitions {
                tempLikesExhibitions.append(exhibitionID) //TODO: 강사님께 물어볼 것 - 이 것 어떻게 처리해야 하는지.
            }
            
            //starPoints
            var tempStarPoints:[[String:Any]] = []
            for stars in starPoints {
                tempStarPoints.append(stars.dictionary)
            }
            
            //comments
            var tempComments:[[String:Any]] = []
            for note in comments {
                tempComments.append(note.dictionary)
            }
            
            return [Constants.user_ID:self.id,
                    Constants.user_Email:self.email,
                    Constants.user_Password:self.password,
                    Constants.user_ProfileImgURL:self.profileImgURL,
                    Constants.user_Name:self.name,
                    Constants.user_LikesExhibitions:tempLikesExhibitions,
                    Constants.user_StarPoints:tempStarPoints,
                    Constants.user_Comments:tempComments]
        }
    }
    
    //init 할 부분
    init(dictionary:[String:Any]) {
        self.id = dictionary[Constants.user_ID] as! Int
        self.email = dictionary[Constants.user_Email] as! String
        self.password = dictionary[Constants.user_Password] as! String
        self.profileImgURL = dictionary[Constants.user_ProfileImgURL] as! String
        self.name = dictionary[Constants.user_Name] as! String
        self.likesExhibitions = []
        self.starPoints = []
        self.comments = []
        
        guard let likesExhibitionContainer:[Int] = dictionary[Constants.user_LikesExhibitions] as? [Int],
            let starPointsContainer:[[String:Any]] = dictionary[Constants.user_StarPoints] as? [[String:Any]],
            let commentsContainer:[[String:Any]] = dictionary[Constants.user_Comments] as? [[String:Any]]
            else { return }
        
        for exhibitionID in likesExhibitionContainer {
            likesExhibitions.append(exhibitionID) //TODO: 강사님께 물어볼 것 - 이 것 어떻게 처리해야 하는지.
        }
        
        for stars in starPointsContainer {
            starPoints.append(StarPoint.init(data: stars))
        }
        
        for note in commentsContainer {
            comments.append(Comment.init(data: note))
        }
    }
}


struct StarPoint {
    let id:Int                              //기본적으로 부여되는 ID 값
    let exhibitionID:Int                    //별점을 준 전시ID
    let point:Point                         //별점
    
    var dictionary:[String:Any] {
        return [Constants.starPoint_ID:self.id,
                Constants.starPoint_exhibitionID:self.exhibitionID,
                Constants.starPoint_Point:self.point]
    }
    
    init(data:[String:Any]) {
        self.id = data[Constants.starPoint_ID] as! Int
        self.exhibitionID = data[Constants.starPoint_exhibitionID] as! Int
        self.point = Point.init(rawValue: data[Constants.starPoint_Point] as! Double)!
    }
}

struct Comment {
    let id:Int                              //기본적으로 부여되는 ID 값
    let exhibitionID:Int                    //어떤 전시에 대한 후기인지 전시의 ID 값 저장
    let userID:Int                          //어떤 유저가 남긴 후기인지 유저의 ID 값 저장
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
        self.userID = data[Constants.comment_UserID] as! Int
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
    let likesFromUser:Int               //좋아요; 유저가 부여한 좋아요 갯수
    let starPointFromUser:Int           //별점; 유저가 부여한 별점의 평균
    let genre:Genre                     //장르
    let district:District               //전시지역
    var placeData:[Place]               //전시장소
    var imgURL:[Image]                  //전시이미지
    var commentsFromUser:[Comment]      //후기
    var periodData:[Period]             //전시기간
    var workingHourData:[WorkingHours]  //관람시간
    
    var dictionary:[String:Any] {
        get{
            var tempPlaceData:[[String:String]] = []
            var tempImageData:[[String:Any]] = []
            var tempCommentsData:[[String:Any]] = []
            var tempPeriodData:[[String:String]] = []
            var tempWorkingHourData:[[String:String]] = []
            
            for place in placeData {
                tempPlaceData.append(place.dictionary)
            }
            for image in imgURL {
                tempImageData.append(image.dictionary)
            }
            for comment in commentsFromUser {
                tempCommentsData.append(comment.dictionary)
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
                    Constants.exhibition_LikesFromUser:self.likesFromUser,
                    Constants.exhibition_StarPointFromUser:self.starPointFromUser,
                    Constants.exhibition_Genre:self.genre,
                    Constants.exhibition_District:self.district,
                    Constants.exhibition_PlaceData:tempPlaceData,
                    Constants.exhibition_ImgURL:tempImageData,
                    Constants.exhibition_CommentsFromUser:tempCommentsData,
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
        self.likesFromUser = data[Constants.exhibition_LikesFromUser] as! Int
        self.starPointFromUser = data[Constants.exhibition_StarPointFromUser] as! Int
        self.genre = Genre.init(rawValue: data[Constants.exhibition_Genre] as! String)!
        self.district = District.init(rawValue: data[Constants.exhibition_District] as! String)!
        self.placeData = []
        self.imgURL = []
        self.commentsFromUser = []
        self.periodData = []
        self.workingHourData = []
        
        if let tempPlaceData:[[String:String]] = data[Constants.exhibition_PlaceData] as? [[String:String]],
            let tempImageData:[[String:Any]] = data[Constants.exhibition_ImgURL] as? [[String:Any]],
            let tempCommentsData:[[String:Any]] = data[Constants.exhibition_CommentsFromUser] as? [[String:Any]],
            let tempPeriodData:[[String:String]] = data[Constants.exhibition_Period] as? [[String:String]],
            let tempWorkingHourData:[[String:String]] = data[Constants.exhibition_WorkingHours] as? [[String:String]] {
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
        self.detailImages = []  // TODO: 강사님께 물어볼 것 - 이 부분 모르겠음
    }
}

struct Period {
    let startDate:String
    let endData:String
    
    var dictionary:[String:String] {
        return [Constants.period_StartDate:self.startDate,
                Constants.period_EndData:self.endData]
    }
    
    init(data:[String:String]) {
        self.startDate = data[Constants.period_StartDate]!
        self.endData = data[Constants.period_EndData]!
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
    case Seoul = "서울특별시"
    case Incheon = "인천광역시"
    case DaeJeon = "대전광역시"
    case DaeGu = "대구광역시"
    case UlSan = "울산광역시"
    case GwangJu = "광주광역시"
    case Busan = "부산광역시"
    case GyeongGi = "경기도"
    case GangWon = "강원도"
    case ChungCheongNam = "충청남도"
    case ChuncCehongBuk = "충청북도"
    case GyeongSangNam = "경상남도"
    case GyeongSangBuk = "경상북도"
    case JeonLaNam = "전라남도"
    case JeonLaBuk = "전라북도"
    case JeJu = "제주도"
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
