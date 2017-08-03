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
    
    var isSearchBtnClicked:Bool = false
    //이게 true이면 검색된 셀이 뜬다
    
    var isBeginEditing:Bool = false
    //이게 true이면 테이블뷰가 비워진다
    
    var isdidChangeText:Bool = false
    //이게 true이면 최근검색어가 나온다
    
    var searchKeyword:[String] = []
    //검색어 버튼이 눌렸을때 여기에 어펜드된다
    
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
        self.rankingTableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
        
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
        isBeginEditing = true
        isdidChangeText = false
        isSearchBtnClicked = false
        print(isSearchBtnClicked,isdidChangeText,isBeginEditing)
        rankingTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색된 작품뷰로 이동")
        isBeginEditing = false
        isdidChangeText = false
        isSearchBtnClicked = true
        searchKeyword.append(searchBar.text!)
        print(isSearchBtnClicked,isdidChangeText,isBeginEditing)
        print(searchKeyword)
        rankingTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("요걸로 검색됨 \(searchText)")
        //이게 빈칸이면, 저장됐던 검색어가 뜬다
        print(isSearchBtnClicked,isdidChangeText,isBeginEditing)
        isBeginEditing = false
        isdidChangeText = true
        isSearchBtnClicked = false
        rankingTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("다시 랭킹뷰로 이동")
        print(isSearchBtnClicked,isdidChangeText,isBeginEditing)
        searchBar.showsCancelButton = false
        searchBar.text = ""
        view.endEditing(true)
        isBeginEditing = false
        isdidChangeText = false
        isSearchBtnClicked = false
        rankingTableView.reloadData()
    }
    
    /*******************************************/
    // MARK: -  TableView                      //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isBeginEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchKeywordCell", for: indexPath)
            //테이블뷰가 비워져야함
            return cell
            
        } else if isdidChangeText {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchKeywordCell", for: indexPath)
            //최근검색어 셀이 나온다
            cell.textLabel?.text = searchKeyword[indexPath.row]
            return cell
            
        } else if isSearchBtnClicked {
            let cell:SearchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            //검색된 셀이 뜬다
            return cell
            
        } else {
            let cell:RankListCustomCell = tableView.dequeueReusableCell(withIdentifier: "RankListCustomCell", for: indexPath) as! RankListCustomCell
            //얘가 기본else일때
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return 1
            
        } else if isdidChangeText {
            //최근검색어 셀이 나온다
            return 1
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다
            return 1
            
        } else {
            //얘가 기본else일때
            return 3
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return 1
            
        } else if isdidChangeText {
            //최근검색어 셀이 나온다
            return searchKeyword.count
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다 -> 나중에 검색결과 갯수로
            return 3
            
        } else {
            //얘가 기본else일때
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return nil
            
        } else if isdidChangeText {
            let header = Bundle.main.loadNibNamed("Sectionheader", owner: self, options: nil)?.first as! Sectionheader
            header.sectionTitleLabel.text = "최근 검색어"
            return header
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다
            return nil
            
        } else if !isBeginEditing && !isdidChangeText && !isSearchBtnClicked {
            let header = Bundle.main.loadNibNamed("Sectionheader", owner: self, options: nil)?.first as! Sectionheader
            header.sectionTitleLabel.text = sectionTitles[section]
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return 0
            
        } else if isdidChangeText {
            //최근검색어 셀이 나온다
            return 30
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다 -> 나중에 검색결과 갯수로
            return 0
            
        } else {
            //얘가 기본else일때
            return 30
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return 0
            
        } else if isdidChangeText {
            //최근검색어 셀이 나온다
            return 30
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다 -> 나중에 검색결과 갯수로
            return 60
            
        } else {
            //얘가 기본else일때
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if isBeginEditing {
            //테이블뷰가 비워져야함
            return nil
            
        } else if isdidChangeText {
            let footer = Bundle.main.loadNibNamed("FooterCell", owner: self, options: nil)?.first as! FooterCell
            footer.footerBtnClicked.setTitle("검색기록 지우기", for: .normal)
            footer.footerBtnClicked.addTarget(self, action: #selector(deleteSearchKeyword), for: .touchUpInside)
            return footer
            
        } else if isSearchBtnClicked {
            //검색된 셀이 뜬다
            return nil
            
        } else if !isBeginEditing && !isdidChangeText && !isSearchBtnClicked {
            return nil
        }
        return nil

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 55
        } else if isdidChangeText {
            return 30
        }
        return 4
    }
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/

    func deleteSearchKeyword(){
        searchKeyword = []
        rankingTableView.reloadData()
    }
    
}
