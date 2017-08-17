//
//  DetailViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

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
        presentPopup(sender)
    }
    
    @IBAction func commentBtnClicked(_ sender: UIButton) {
        presentPopup(sender)
    }
    
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        self.navigationController?.isNavigationBarHidden = false

//        if introduceExsHeight.constant > 0 {
//            contentsViewHeight.constant += introduceExsHeight.constant
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(UINib(nibName: "UserCommentCustomCell", bundle: nil), forCellReuseIdentifier: "UserCommentCustomCell")
        print("viewDidLoad")
        
        self.posterCollectionView.delegate = self
        self.posterCollectionView.dataSource = self
        self.posterCollectionView.register(UINib(nibName: "RankingCustomCell", bundle: nil), forCellWithReuseIdentifier: "RankingCustomCell")
        
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RankingCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
        cell.rankImage.isHidden = true
        return cell
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentPopup(_ sender: UIButton){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        popup.senderTag = sender.tag
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
