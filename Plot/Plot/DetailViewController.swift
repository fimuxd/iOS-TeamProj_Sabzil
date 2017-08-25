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
    var detailImgArray:[String] = []
    var commentDataArray:[[String:Any]] = []
    
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
        self.likeButtonAction()
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
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
        
        guard let realExhibitionID:Int = self.exhibitionID else {
            return print("전시데이터가 없습니다")
        }
        
        self.loadExhibitionData(itemOfIndexPath: realExhibitionID)
        self.loadDetailImgArrayForCollectionView(itemOfIndexPath: realExhibitionID)
        self.loadLikeData(exhibitionID: realExhibitionID)
        self.loadCommentData(exhibitionID: realExhibitionID)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCommentCustomCell = tableView.dequeueReusableCell(withIdentifier: "UserCommentCustomCell", for: indexPath) as! UserCommentCustomCell
        cell.selectionStyle = .none
        
        DispatchQueue.global(qos: .default).async {
            guard let userID:String = self.commentDataArray[indexPath.row][Constants.comment_UserID] as? String else {return}
            Database.database().reference().child("UserData").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String:String] else {return}
                let profileImgURL:String = json[Constants.user_ProfileImgURL]!
                
                DispatchQueue.main.async {
                    
                    cell.userNickNameLabel.text = json[Constants.user_Name]
                    
                    guard let commentDetail:String = self.commentDataArray[indexPath.row][Constants.comment_Detail] as? String else {return}
                    cell.commentDetailLabel.text = commentDetail
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentDataArray.count
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
        
        guard let url = URL(string: self.detailImgArray[indexPath.item]) else {
            print("URL을 불러오지 못했습니다")
            return cell
        }
        
        do{
            let realData = try Data(contentsOf: url)
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
        popup.exhibitionID = self.exhibitionID!
        present(popup, animated: true, completion: nil)
    }
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "StarPointPopup") as! StarPointPopupViewController
        popup.exhibitionID = self.exhibitionID
        present(popup, animated: true, completion: nil)
    }
    
    func reloadComment(){
        guard let exhibitionID:Int = self.exhibitionID else {return}
        self.loadCommentData(exhibitionID: exhibitionID)
    }
    
    //해당 전시에 대한 내용을 불러와서 뿌립니다.
    func loadExhibitionData(itemOfIndexPath:Int) {
        Database.database().reference().child("ExhibitionData").child("\(itemOfIndexPath)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [String:Any] else {return}
            
            self.exhibitionTitle.text = json[Constants.exhibition_Title] as? String
            
            guard let periodDic:[String:String] = json[Constants.exhibition_Period] as? [String:String],
                let startDateStr:String = periodDic[Constants.period_StartDate],
                let endDateStr:String = periodDic[Constants.period_EndDate] else {return}
            self.exhibitionDate.text = "\(startDateStr) ~ \(endDateStr)"
            
            guard let placeDic:[String:String] = json[Constants.exhibition_PlaceData] as? [String:String],
                let addressStr:String = placeDic[Constants.place_Address],
                let websiteStr:String = placeDic[Constants.place_WebsiteURL] else {return}
            self.exhibitionPlace.text = addressStr
            
            guard let workingHoursDic:[String:String] = json[Constants.exhibition_WorkingHours] as? [String:String],
                let startTime:String = workingHoursDic[Constants.workingHours_StartTime],
                let endTime:String = workingHoursDic[Constants.workingHours_EndTime] else {return}
            self.exhibitionTime.text = "\(startTime) ~ \(endTime)"
            
            self.exhibitionPrice.text = "\(json[Constants.exhibition_Admission] as? Int ?? 0)원"
            self.exhibitionAgent.text = json[Constants.exhibition_Artist] as? String
            self.exhibitionHomepage.setTitle(websiteStr, for: .normal)
            self.exhibitionGenre.text = json[Constants.exhibition_Genre] as? String
            self.exhibitionAge.text = "전체관람가"
            self.exhibitionIntroduce.text = json[Constants.exhibition_Detail] as? String
            
            guard let imageDic:[String:Any] = json[Constants.exhibition_ImgURL] as? [String:Any],
                let posterImgURL:String = imageDic[Constants.image_PosterURL] as? String else {return}
            
            guard let posterurl = URL(string: posterImgURL) else {return}
            do{
                let realData = try Data(contentsOf: posterurl)
                self.posterImg.image = UIImage(data: realData)
            }catch{
                
            }
        },withCancel: { (error) in
            print(error.localizedDescription)
        })
    }
    
    
    //전시의 디테일이미지들을 콜렉션뷰에 뿌립니다.
    func loadDetailImgArrayForCollectionView(itemOfIndexPath:Int) {
        self.activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("ExhibitionData").child("\(itemOfIndexPath)").child(Constants.exhibition_ImgURL).child(Constants.image_DetailImages).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String] else {return}
                    self.detailImgArray = json
                
                DispatchQueue.main.async {
                    self.posterCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
            
        }
    }
    
    //전시의 좋아요 여부를 표시합니다.
    func loadLikeData(exhibitionID:Int) {
        DispatchQueue.global(qos: .default).async {
            Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let json = snapshot.value as? [String:[String:Any]] else {return}
                
                let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                    var exhibitionNumber:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                    return exhibitionNumber == exhibitionID
                })
                
                DispatchQueue.main.async {
                    switch filteredLikeData.count {
                    case 0:
                        self.displayLike.image = #imageLiteral(resourceName: "likeBtn_off")
                    case 1:
                        self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
                    default:
                        print("좋아요 버튼표시에러: \(filteredLikeData)")
                    }
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
        
    }
    
    //좋아요를 누를 때마다 데이터 및 UI를 반영하여 나타냅니다.
    func likeButtonAction() {
        guard let realExhibitionID:Int = self.exhibitionID else {return}
        Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [String:[String:Any]] else {return}
            print("여기여기여기:\(json)")
            
            let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                var exhibitionID:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                return exhibitionID == realExhibitionID
            })
            
            
            switch filteredLikeData.count {
            case 0:
                self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
                Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:realExhibitionID,
                                                                                         Constants.likes_UserID:Auth.auth().currentUser?.uid])
            case 1:
                self.displayLike.image = #imageLiteral(resourceName: "likeBtn_off")
                Database.database().reference().child("Likes").child(filteredLikeData[0].key).setValue(nil)
            default:
                print("좋아요 버튼액션에러: \(filteredLikeData)")
            }
            
        }, withCancel: { (error) in
            print(error.localizedDescription)
        })
        
        Database.database().reference().child("Likes").queryOrdered(byChild: Constants.likes_UserID).queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.childChanged, with: { (snapshot) in
            guard let json = snapshot.value as? [String:[String:Any]] else {return}
            print("여기여기여기:\(json)")
            
            let filteredLikeData = json.filter({ (dic:(key: String, value: [String : Any])) -> Bool in
                var exhibitionID:Int = dic.value[Constants.likes_ExhibitionID] as! Int
                return exhibitionID == realExhibitionID
            })
            
            
            switch filteredLikeData.count {
            case 0:
                self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
                Database.database().reference().child("Likes").childByAutoId().setValue([Constants.likes_ExhibitionID:realExhibitionID,
                                                                                         Constants.likes_UserID:Auth.auth().currentUser?.uid])
            case 1:
                self.displayLike.image = #imageLiteral(resourceName: "likeBtn_off")
                Database.database().reference().child("Likes").child(filteredLikeData[0].key).setValue(nil)
            default:
                print("좋아요 버튼액션에러: \(filteredLikeData)")
            }
            
        }, withCancel: { (error) in
            print(error.localizedDescription)
        })
        
    }
    
    //코멘트 정보를 불러와서 코멘트 테이블뷰에 뿌립니다.
    func loadCommentData(exhibitionID:Int) {
        guard let realExhibitionID:Int = self.exhibitionID else {return}
        Database.database().reference().child("Comments").queryOrdered(byChild: Constants.comment_ExhibitionID).queryEqual(toValue: exhibitionID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let json = snapshot.value as? [String:[String:Any]] else {return}
            let mappedJson = json.map({ (dic:(key: String, value: [String : Any])) -> [String:Any] in
                return dic.value
            })
            self.commentDataArray = mappedJson
            self.commentTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
