//
//  DetailViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    
    @IBOutlet weak var commentTableView: UITableView!
    var exhibitionID:Int?
    //    var selectedExhibition:ExhibitionData = ExhibitionData(data: [:])
    var userLikesData:[(key: String, value: [String : Any])] = []
    var detailImgArray:[String] = []
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    // MARK: - Info
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var exhibitionTitle: UILabel!
    @IBOutlet weak var exhibitionDate: UILabel!
    @IBOutlet weak var exhibitionPlace: UILabel!
    @IBOutlet weak var exhibitionTime: UILabel!
    @IBOutlet weak var exhibitionPrice: UILabel!
    @IBOutlet weak var exhibitionAgent: UILabel!
    @IBOutlet weak var exhibitionHomepage: UIButton!
    @IBOutlet weak var exhibitionGenre: UILabel!
    @IBOutlet weak var exhibitionAge: UILabel!
    @IBOutlet weak var exhibitionIntroduce: UILabel!
    
    // MARK: - Star Score
    @IBOutlet weak var firScoreStar: UIImageView!
    @IBOutlet weak var secScoreStar: UIImageView!
    @IBOutlet weak var thiScoreStar: UIImageView!
    @IBOutlet weak var fouScoreStar: UIImageView!
    @IBOutlet weak var fivScoreStar: UIImageView!
    
    // MARK: - IBAction
    @IBAction func starPoint(_ sender: UIButton) {
        presentStarPointPopup()
    }
    
    @IBAction func commentBtnClicked(_ sender: UIButton) {
        presentCommentPopup()
    }
    
    @IBOutlet weak var displayLike: UIImageView!
    
    @IBAction func likeBtnClicked(_ sender: UIButton) {
        
        if self.displayLike.image == #imageLiteral(resourceName: "likeBtn_on") {
            self.displayLike.image = #imageLiteral(resourceName: "likeBtn_off")
            
            if self.userLikesData.count != 0 {
                let keyString:String = self.userLikesData[0].key
                Database.database().reference().child("Likes").child(keyString).setValue(nil)
                self.userLikesData = []
            }
            
        }else{
            self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
            
            if self.userLikesData.count == 0 {
                
                Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_UserID:Auth.auth().currentUser?.uid,
                                                                                         Constants.likes_ExhibitionID:self.exhibitionID!])
            }
            
        }
    }
    
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = false
        
        //        if introduceExsHeight.constant > 0 {
        //            contentsViewHeight.constant += introduceExsHeight.constant
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadComment), name: NSNotification.Name("dismissPopup"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadComment), name: NSNotification.Name("dismissStarPopup"), object: nil)
        
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(UINib(nibName: "UserCommentCustomCell", bundle: nil), forCellReuseIdentifier: "UserCommentCustomCell")
        
        self.posterCollectionView.delegate = self
        self.posterCollectionView.dataSource = self
        self.posterCollectionView.register(UINib(nibName: "RankingCustomCell", bundle: nil), forCellWithReuseIdentifier: "RankingCustomCell")
        
        loadData(RowOfIndexPath: self.exhibitionID!)
        
        /*
         var selectedExhibition:ExhibitionData?{
         didSet{
         guard let realExhibitionData = selectedExhibition else {
         print("리얼데이터가 없습니다")
         return
         }
         
         self.exhibitionTitle.text = realExhibitionData.title
         self.exhibitionDate.text = "\(realExhibitionData.periodData[0].startDate) ~ \(realExhibitionData.periodData[0].endDate)"
         self.exhibitionPlace.text = realExhibitionData.placeData[0].address
         self.exhibitionTime.text = "\(realExhibitionData.workingHourData[0].startTime) ~ \(realExhibitionData.workingHourData[0].endTime)"
         self.exhibitionPrice.text = "\(realExhibitionData.admission)원"
         self.exhibitionAgent.text = realExhibitionData.artist
         self.exhibitionHomepage.setTitle(realExhibitionData.placeData[0].websiteURL, for: .normal)
         self.exhibitionGenre.text = realExhibitionData.genre.rawValue
         self.exhibitionAge.text = "전체관람가"
         self.exhibitionIntroduce.text = realExhibitionData.detail
         guard let url = URL(string: realExhibitionData.imgURL[0].posterURL) else {return}
         
         do{
         let realData = try Data(contentsOf: url)
         self.posterImg.image = UIImage(data: realData)
         }catch{
         
         }
         
         if self.userLikesData.count != 0 {
         self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
         
         }
         
         self.detailImgCount = realExhibitionData.imgURL[0].detailImages.count
         self.posterCollectionView.reloadData()
         }
         }
         
         DataCenter.sharedData.requestExhibitionData(id: self.exhibitionID) { (exhibition) in
         selectedExhibition = exhibition
         }
         */
        
        //좋아요
        Database.database().reference().child("Likes").keepSynced(true)
        
        DataCenter.sharedData.requestLikeDataFor(exhibitionID: self.exhibitionID!, userID: Auth.auth().currentUser?.uid, completion: { (datas) in
            self.userLikesData = datas
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCommentCustomCell = tableView.dequeueReusableCell(withIdentifier: "UserCommentCustomCell", for: indexPath) as! UserCommentCustomCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: 150 * 4/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailImgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RankingCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
        
        let detailImgURL = URL(string: self.detailImgArray[indexPath.item])
        
        do{
            let realData = try Data(contentsOf: detailImgURL!)
            cell.posterImage.image = UIImage(data: realData)
            
        }catch{
            
        }
        
        cell.rankImage.isHidden = true
        return cell
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentCommentPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        popup.exhibitionID = self.exhibitionID
        present(popup, animated: true, completion: nil)
    }
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "StarPointPopup") as! StarPointPopupViewController
        popup.exhibitionID = self.exhibitionID
        present(popup, animated: true, completion: nil)
    }
    
    func reloadComment(){
        print("코멘트테이블뷰리로드")
        self.commentTableView.reloadData()
    }
    
    func loadData(RowOfIndexPath:Int) {
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("ExhibitionData").child("\(RowOfIndexPath)").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String:Any] else {return}
                
                DispatchQueue.main.async {
                    self.exhibitionTitle.text = json[Constants.exhibition_Title] as! String
                    
                    let periodDic:[String:String] = json[Constants.exhibition_Period] as! [String:String]
                    let startDateStr:String = periodDic[Constants.period_StartDate] as! String
                    let endDateStr:String = periodDic[Constants.period_EndDate] as! String
                    self.exhibitionDate.text = "\(startDateStr) ~ \(endDateStr)"
                    
                    let placeDic:[String:String] = json[Constants.exhibition_PlaceData] as! [String:String]
                    let addressStr:String = json[Constants.exhibition_Artist] as! String
                    let websiteStr:String = placeDic[Constants.place_WebsiteURL] as! String
                    self.exhibitionPlace.text = addressStr
                    
                    let workingHoursDic:[String:String] = json[Constants.exhibition_WorkingHours] as! [String:String]
                    let startTime:String = workingHoursDic[Constants.workingHours_StartTime] as! String
                    let endTime:String = workingHoursDic[Constants.workingHours_EndTime] as! String
                    self.exhibitionTime.text = "\(startTime) ~ \(endTime)"
                    
                    self.exhibitionPrice.text = "\(json[Constants.exhibition_Admission] as! Int)원"
                    self.exhibitionAgent.text = json[Constants.exhibition_Artist] as! String
                    self.exhibitionHomepage.setTitle(websiteStr, for: .normal)
                    self.exhibitionGenre.text = json[Constants.exhibition_Genre] as! String
                    self.exhibitionAge.text = "전체관람가"
                    self.exhibitionIntroduce.text = json[Constants.exhibition_Detail] as! String
                    
                    let imageDic:[String:Any] = json[Constants.exhibition_ImgURL] as! [String:Any]
                    let posterImgURL:String = imageDic[Constants.image_PosterURL] as! String
                    let detailImg:[String] = imageDic[Constants.image_DetailImages] as! [String]
                    
                    guard let posterurl = URL(string: posterImgURL) else {return}
                    do{
                        let realData = try Data(contentsOf: posterurl)
                        self.posterImg.image = UIImage(data: realData)
                    }catch{
                        
                    }
                    
                    if self.userLikesData.count != 0 {
                        self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
                        
                    }
                    
                    self.detailImgArray = detailImg
                    self.posterCollectionView.reloadData()
                    
                }
                print("===\(RowOfIndexPath)번 전시 제이슨로딩중===")
                
            },withCancel: { (error) in
                print(error.localizedDescription)
            })
            
        }
    }
    
}
