//
//  Constants.swift
//  Plot
//
//  Created by Bo-Young PARK on 1/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import Foundation

struct Constants {
    // - A. UserData 부분
    static let user_ID:String = "user_ID"                               //기본적으로 부여되는 ID 값 (로그인아이디 아님)
    static let user_Email:String = "user_Email"                         //이메일
    static let user_Password:String = "user_Password"                   //비밀번호
    static let user_ProfileImgURL:String = "user_ProfileImgURL"         //프로필사진 URL
    static let user_Name:String = "user_Name"                           //유저명
    static let user_LikesExhibitions:String = "user_LikesExhibitions"   //좋아요; Exibition의 ID값을 Array로 저장
    static let user_StarPoints:String = "user_StarPoints"               //별점
    static let user_Comments:String = "user_Comments"                   //후기
    
    // - B. ExhibitionData 부분
    static let exhibition_ID:String = "exhibition_ID"                               //기본적으로 부여되는 ID 값
    static let exhibition_Title:String = "exhibition_Title"                         //전시제목
    static let exhibition_Artist:String = "exhibition_Artist"                       //전시주체(작가/단체)
    static let exhibition_Genre:String = "exhibition_Genre"                         //장르
    static let exhibition_District:String = "exhibition_District"                   //전시지역
    static let exhibition_Admission:String = "exhibition_Admission"                 //관람료
    static let exhibition_Detail:String = "exhibition_Detail"                       //작품설명
    static let exhibition_LikesFromUser:String = "exhibition_LikesFromUser"         //좋아요; 유저가 부여한 좋아요 갯수
    static let exhibition_StarPointFromUser:String = "exhibition_StarPointFromUser" //별점; 유저가 부여한 별점의 평균
    static let exhibition_PlaceData:String = "exhibition_PlaceData"                 //전시장소
    static let exhibition_ImgURL:String = "exhibition_ImgURL"                       //전시이미지
    static let exhibition_CommentsFromUser:String = "exhibition_CommentsFromUser"   //후기
    static let exhibition_Period:String = "exhibition_Period"                       //전시기간
    static let exhibition_WorkingHours:String = "exhibition_WorkingHours"           //관람시간
    
    // - C. 하위 dictionary 부분
    static let starPoint_ID:String = "starPoint_ID"                     //기본적으로 부여되는 ID 값
    static let starPoint_exhibitionID:String = "starPoint_exhibitionID" //별점을 준 전시ID
    static let starPoint_Point:String = "starPoint_Point"               //별점
    
    static let comment_ID:String = "comment_ID"                         //기본적으로 부여되는 ID 값
    static let comment_ExhibitionID:String = "comment_ExhibitionID"     //어떤 전시에 대한 후기인지 전시의 ID 값 저장
    static let comment_UserID:String = "comment_UserID"                 //어떤 유저가 남긴 후기인지 유저의 ID 값 저장
    static let comment_Detail:String = "comment_Detail"                 //후기
    
    static let place_Address:String = "place_Address"           //전시장소 주소
    static let place_WebsiteURL:String = "place_WebsiteURL"     //전시 웹사이트 URL
    
    static let image_PosterURL:String = "image_PosterURL"           //메인포스터
    static let image_DetailImages:String = "image_DetailImages"     //디테일포스터 Array
    
    static let period_StartDate:String = "period_StartDate"     //전시기간_시작날짜
    static let period_EndData:String = "period_EndData"         //전시기간_종료날짜
    
    static let workingHours_StartTime:String = "workingHours_StartTime"     //전시시간_시작시간
    static let workingHours_EndTime:String = "workingHours_EndTime"         //전시시간_종료시간
    
}
