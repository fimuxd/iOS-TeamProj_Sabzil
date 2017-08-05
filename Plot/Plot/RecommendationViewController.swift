//
//  RecommendationViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var recommendTableView: UITableView!
    let localTag:[String] = ["미술","사진","영상","공예","조각","설치","기타"]
    let genreTag:[String] = ["서울","부산","광주","대구","대전","경기도","경상도","강원도","충청도","전라도","제주도"]
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.register(UINib(nibName: "TagCustomCell", bundle: nil), forCellWithReuseIdentifier: "TagCustomCell")
        
        self.recommendTableView.delegate = self
        self.recommendTableView.dataSource = self
        self.recommendTableView.register(UINib(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return genreTag.count
        }else if section == 1 {
            return localTag.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TagCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCustomCell", for: indexPath) as! TagCustomCell
        if indexPath.section == 0 {
            cell.tagBtn.setTitle(genreTag[indexPath.row], for: .normal)
        }else if indexPath.section == 1 {
            cell.tagBtn.setTitle(localTag[indexPath.row], for: .normal)
        }
        
        return cell
    }
    
    
    
    
}
