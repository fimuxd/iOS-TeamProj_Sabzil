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
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(UINib(nibName: "UserCommentCustomCell", bundle: nil), forCellReuseIdentifier: "UserCommentCustomCell")
        
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
    

}
