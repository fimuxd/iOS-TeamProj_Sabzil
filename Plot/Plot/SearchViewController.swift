//
//  SearchViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rankingTableView: UITableView!
    let sectionTitles:[String] = ["좋아요 랭킹","별점 랭킹","딴거"]

    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        searchBar.placeholder = "전시명, 지역, 장르 등 검색"
        self.rankingTableView.dataSource = self
        self.rankingTableView.delegate = self
        self.rankingTableView.register(UINib(nibName: "RankListCustomCell", bundle: nil), forCellReuseIdentifier: "RankListCustomCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*******************************************/
    // MARK: -  Search Bar                     //
    /*******************************************/
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("서치바 눌려뜸 / 새로운 테이블뷰 모달되야되는데 서치바는 가만히있어야댐")
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색된 작품뷰로 이동")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("요걸로 검색됨 \(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("다시 랭킹뷰로 이동")
        searchBar.showsCancelButton = false
        searchBar.text = ""
        view.endEditing(true)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = Bundle.main.loadNibNamed("Sectionheader", owner: self, options: nil)?.first as! Sectionheader
        header.sectionTitleLabel.text = sectionTitles[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 55
        }
        return 4
    }


}
