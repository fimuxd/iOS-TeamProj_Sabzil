//
//  RankingViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 4..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class RankingViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var sectionOfIndexPath:Int?
    var rowOfIndexPath:Int?
    
    var seoulExhibitionCount:Int = 0
    var gyeonggiExhibitionCount:Int = 0
    var busanExhibitionCount:Int = 0
    
    var paintExhibitionCount:Int = 0
    var installationExbhitiionCount:Int = 0
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var rankingCollectionView: UICollectionView!
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        
        awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLoginVC()
        self.rankingCollectionView.delegate = self
        self.rankingCollectionView.dataSource = self
        self.rankingCollectionView.register(UINib(nibName: "RankingCustomCell", bundle: nil), forCellWithReuseIdentifier: "RankingCustomCell")
        
        Database.database().reference().child("ExhibitionData").keepSynced(true)
        
        if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 0 {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_District).queryEqual(toValue: District.Seoul.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                self.seoulExhibitionCount = Int(snapshot.childrenCount)
                self.rankingCollectionView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 1 {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_District).queryEqual(toValue: District.GyeongGi.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                self.gyeonggiExhibitionCount = Int(snapshot.childrenCount)
                self.rankingCollectionView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 2 {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_District).queryEqual(toValue: District.Busan.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                self.busanExhibitionCount = Int(snapshot.childrenCount)
                self.rankingCollectionView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 0 {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_Genre).queryEqual(toValue: Genre.Paint.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                self.paintExhibitionCount = Int(snapshot.childrenCount)
                self.rankingCollectionView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 1 {
            Database.database().reference().child("ExhibitionData").queryOrdered(byChild: Constants.exhibition_Genre).queryEqual(toValue: Genre.Installation.rawValue).queryLimited(toFirst: 9).observeSingleEvent(of: .value, with: { (snapshot) in
                self.installationExbhitiionCount = Int(snapshot.childrenCount)
                self.rankingCollectionView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        print("랭킹여기")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 0 {
            return self.seoulExhibitionCount
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 1 {
            return self.gyeonggiExhibitionCount
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 2 {
            return self.busanExhibitionCount
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 0 {
            return self.paintExhibitionCount
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 1 {
            return self.installationExbhitiionCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
        
        if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 0 {
            cell.getExhibitionData(OfDistrict: District.Seoul, itemOfIndexPath: indexPath.item)
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 1 {
            cell.getExhibitionData(OfDistrict: District.GyeongGi, itemOfIndexPath: indexPath.item)
        }else if self.sectionOfIndexPath == 0 && self.rowOfIndexPath == 2 {
            cell.getExhibitionData(OfDistrict: District.Busan, itemOfIndexPath: indexPath.item)
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 0 {
            cell.getExhibitionData(OfGenre: Genre.Paint, itemOfIndexPath: indexPath.item)
        }else if self.sectionOfIndexPath == 1 && self.rowOfIndexPath == 1 {
            cell.getExhibitionData(OfGenre: Genre.Installation, itemOfIndexPath: indexPath.item)
        }
        
        switch indexPath.item {
        case 0:
            cell.rankImage.image = #imageLiteral(resourceName: "rangking_1st")
        case 1:
            cell.rankImage.image = #imageLiteral(resourceName: "rangking_2nd")
        case 2:
            cell.rankImage.image = #imageLiteral(resourceName: "rangking_3rd")
        default:
            cell.rankImage.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 147)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detaileView:DetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detaileView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 20)
    }
    
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func presentLoginVC(){
        if Auth.auth().currentUser == nil {
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }else{
            print(Auth.auth().currentUser?.email)
        }
    }
    
}
