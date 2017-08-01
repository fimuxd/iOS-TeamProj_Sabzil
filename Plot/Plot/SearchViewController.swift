//
//  SearchViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var rankingTableView: UITableView!
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rankingTableView.dataSource = self
        self.rankingTableView.delegate = self
        self.rankingTableView.register(UINib(nibName: "RankListCustomCell", bundle: nil), forCellReuseIdentifier: "RankListCustomCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*******************************************/
    // MARK: -  TableView                      //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RankListCustomCell = tableView.dequeueReusableCell(withIdentifier: "RankListCustomCell", for: indexPath) as! RankListCustomCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "좋아요 랭킹"
        case 1:
            return "별점 랭킹"
        case 2:
            return "다른등등 랭킹"
        default:
            return "알수 없는 값"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}
