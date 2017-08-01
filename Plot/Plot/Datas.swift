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
    let user_ID:Int                         //기본적으로 부여되는 ID 값 (로그인아이디 아님)
    let user_Email:String                   //이메일
    let user_Password:String                //비밀번호
    let user_ProfileImgURL:String           //프로필사진 URL
    let user_Name:String                    //유저명
    let user_LikesExibitions:[Int]          //좋아요; Exibition의 ID값을 Array로 저장
    let user_StarPoints:[StarPoint]         //별점
    let user_Conments:[Comment]              //후기
}

struct StarPoint {
    let starPoint_ID:Int                    //기본적으로 부여되는 ID 값
    let starPoint_ExibitionID:Int           //별점을 준 전시ID
    let starPoint_Point:Point                 //별점
}

struct Comment {
    let comment_ID:Int                       //기본적으로 부여되는 ID 값
    let comment_Detail:String                //후기
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
}


//-----ExhibitionData
struct ExibitionData {
    let exibition_ID:Int                    //기본적으로 부여되는 ID 값
    let exibition_Title:String              //전시제목
    let exibition_Artist:String             //전시주체(작가/단체)
    let exibition_PlaceData:[Place]         //전시장소
    let exibition_ImgURL:[Image]            //전시이미지
    let exibition_Period:[String]           //전시기간
    let exibition_Time:[String]             //관람시간
    let exibition_Genre:Genre               //장르
    let exibition_District:District         //전시지역
    let exibition_Admission:Int             //관람료
    let exibition_Detail:String             //작품설명
    let exibition_LikesFromUser:Int         //좋아요; 유저가 부여한 좋아요 갯수
    let exibition_StarPointFromUser:Int     //별점; 유저가 부여한 별점의 평균
    let exibition_ComentsFromUser:[Comment]  //후기
    
}

struct Place {
    let place_Address:String                //전시장소 주소
    let place_WebsiteURL:String?            //전시관련 Website
}

struct Image {
    let image_PosterURL:String              //메인포스터
    let image_DetailImage:[String]          //디테일포스터 Array
}

enum Genre {
    case Paint                              //미술
    case Photo                              //사진
    case Video                              //영상
    case Craft                              //공예
    case Carving                            //조각
    case Installation                       //설치
    case Etc                                //기타
}

enum District {
    case Seoul                              //서울
    case Incheon                            //인천
    case DaeJeon                            //대전
    case DaeGu                              //대구
    case UlSan                              //울산
    case GwangJu                            //광주
    case Busan                              //부산
    case GyeongGi                           //경기도
    case GangWon                            //강원도
    case ChungCheongNam                     //충청남도
    case ChuncCehongBuk                     //충청북도
    case GyeongSangNam                      //경상남도
    case GyeongSangBuk                      //경상북도
    case JeonLaNam                          //전라남도
    case JeonLaBuk                          //전라북도
    case JeJu                               //제주도
}
