//
//  RankingViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 4..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCustomCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 147)
    }
}
