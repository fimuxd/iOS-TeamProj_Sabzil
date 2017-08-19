//
//  RankingViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 4..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class RankingViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentLoginVC()
        self.rankingCollectionView.delegate = self
        self.rankingCollectionView.dataSource = self
        self.rankingCollectionView.register(UINib(nibName: "RankingCustomCell", bundle: nil), forCellWithReuseIdentifier: "RankingCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath) as! RankingCustomCell
        
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
    
    func presentLoginVC(){
        if Auth.auth().currentUser == nil {
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }else{
            print(Auth.auth().currentUser?.email)
        }
    }
}
