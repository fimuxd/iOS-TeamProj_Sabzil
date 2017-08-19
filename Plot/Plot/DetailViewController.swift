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
    var userLikesExhi:[String] = []
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
        print("버튼이 눌림")
        
        var isLike:Bool?{
            didSet{
                guard let realBool = isLike else {return}
                print("여기")
                if realBool == true {
                    print("저기")
                    self.displayLike.image = #imageLiteral(resourceName: "likeBtn_off")
//                    Database.database().reference().child("Likes")
                    
                }else{
                    print("거기")
                    self.displayLike.image = #imageLiteral(resourceName: "likeBtn_on")
                }
            }
        }
        DataCenter.sharedData.isLiked(exhibitionID: self.exhibitionID, userID: Auth.auth().currentUser?.uid) { (bool) in
            isLike = bool
        }
        
        /*
         이거를 눌렀을때, 전시데이터의 like갯수가 올라가고,
         해당 유저의 좋아요목록에 이 전시id가 들어가고
         만약 이 전시 id를 검색해서 좋아요가 눌려있다면
         이미지뷰의 이미지가 tint바뀐다.
         다시 좋아요를 눌렀을때는, 전시데이터 like갯수가 줄어들고
         해당 유저의 좋아요 목록에서 이 전시 Id가 사라지며
         이 전시 id를 검색해 좋아요가 사라져있다면
         이미지뷰의 이미지가 노말로 바뀐다
         */
    }
    
    var exhibitionID:Int?
    
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
                    print("loading Image")
                }catch{
                    
                }
                
            }
        }
        DataCenter.sharedData.requestExhibitionData(id: self.exhibitionID) { (exhibition) in
            selectedExhibition = exhibition
        }
        
        
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RankingCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
        cell.rankImage.isHidden = true
        
        var detailImg:[String]?{
            didSet{
                guard let realImgs = detailImg else {return}
                
                guard let url = URL(string: realImgs[indexPath.item]) else {return}
                
                do{
                    let realData = try Data(contentsOf: url)
                    cell.posterImage.image = UIImage(data: realData)
                    print("loading Image")
                }catch{
                    
                }
            }
        }
        
        var exhibitionData:ExhibitionData? {
            didSet{
                guard let realExhibitionData = exhibitionData else {return}
                detailImg = realExhibitionData.imgURL[0].detailImages
            }
        }
        DataCenter.sharedData.requestExhibitionData(id: self.exhibitionID) { (data) in
            exhibitionData = data
        }
        return cell
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentCommentPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        present(popup, animated: true, completion: nil)
    }
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "StarPointPopup") as! StarPointPopupViewController
        present(popup, animated: true, completion: nil)
    }
    
    func reloadComment(){
        print("코멘트테이블뷰리로드")
        self.commentTableView.reloadData()
    }
    
//    var reloadComment = {()->Void in
//        self.reloadComment()
//    }
}
