//
//  MyPageViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBAction func clickedLogout(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "LoginTest")
        presentLoginVC()
    }
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    var likeExhi:[String] = []
    var likeGenre:[String] = ["으어어어어어", "이거머야", "무서어"]
    
    var sizingCell: TagCustomCell?
    
    var liketag = [Tag]()
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for name in likeGenre {
            let tag = Tag()
            tag.name = name
            self.liketag.append(tag)
        }
        
        print(liketag)
        
        self.posterCollectionView.register(UINib(nibName: "RankingCustomCell", bundle: nil), forCellWithReuseIdentifier: "RankingCustomCell")
        
        self.tagCollectionView.register(UINib(nibName: "TagCustomCell", bundle: nil), forCellWithReuseIdentifier: "TagCustomCell")
        
        self.tagCollectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader")
        
        self.posterCollectionView.delegate = self
        self.posterCollectionView.dataSource = self
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.delegate = self
        
        let cellNib = UINib(nibName: "TagCustomCell", bundle: nil)
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCustomCell?
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == posterCollectionView {
            return 1
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == posterCollectionView {
            return 10
        } else {
            return liketag.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == posterCollectionView {
            return CGSize(width: 150, height: 150 * 4/3)
        } else {
            self.configureCell(self.sizingCell!, forIndexPath: indexPath)
            return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == posterCollectionView {
            let cell:RankingCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
            cell.rankImage.isHidden = true
            return cell
            
        } else {
            let cell:TagCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCustomCell", for: indexPath) as! TagCustomCell
            self.configureCell(cell, forIndexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header:CollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! CollectionViewHeader
        //        if collectionView == posterCollectionView {
        //            header.headerName.text! = "좋아요 목록"
        header.headerName.text! = "선호하는 장르"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == posterCollectionView {
            return CGSize.init(width: 0, height: 0)
        }
        return CGSize.init(width: collectionView.frame.size.width, height: 30)
    }
    
    func configureCell(_ cell: TagCustomCell, forIndexPath indexPath: IndexPath) {
        
        let tag = liketag[indexPath.row]
        cell.tagName.text = tag.name
        cell.tagName.textColor = tag.selected ? UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1) : UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1)
        cell.backgroundColor = tag.selected ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if collectionView == tagCollectionView {
            liketag[indexPath.row].selected = !liketag[indexPath.row].selected
        }
        self.tagCollectionView.reloadData()
    }
    
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentLoginVC(){
        if !UserDefaults.standard.bool(forKey: "LoginTest"){
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }
    }
    
}
