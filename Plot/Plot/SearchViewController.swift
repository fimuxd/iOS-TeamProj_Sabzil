//
//  SearchViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rankingTableView: UITableView!
    let sectionTitles:[String] = ["지역별","장르별","기타"]
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentLoginVC()
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
        if !searchKeyword.contains(searchBar.text!) {
            searchKeyword.append(searchBar.text!)
        }
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
            cell.selectionStyle = .none
            //검색된 셀이 뜬다
            return cell
            
        } else {
            let cell:RankListCustomCell = tableView.dequeueReusableCell(withIdentifier: "RankListCustomCell", for: indexPath) as! RankListCustomCell
            cell.selectionStyle = .none
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.rankingTitleTextLabel.text = "요즘 서울에서 뜨는 전시"
                    cell.cellBgImageView.image = #imageLiteral(resourceName: "seoul_low")

                    DispatchQueue.main.async {
                        Storage.storage().reference().child("seoul_high.jpg").downloadURL(completion: { (url, error) in
                            if let error = error {
                                print("error:\(error)")
                            }
                            
                            guard let url = url else {return}
                            
                            do{
                                let realData = try Data(contentsOf: url)
                                cell.cellBgImageView.image = UIImage(data: realData)
                            }catch{
                            }
                        })
                    }
 
                }else if indexPath.row == 1{
                    cell.rankingTitleTextLabel.text = "이번 주말엔 경기도 어떠세요?"
                    cell.cellBgImageView.image = #imageLiteral(resourceName: "gyeongi_low")
                    
                    DispatchQueue.main.async {
                        Storage.storage().reference().child("gyeongi_high.jpg").downloadURL(completion: { (url, error) in
                            if let error = error {
                                print("error:\(error)")
                            }
                            
                            guard let url = url else {return}
                            
                            do{
                                let realData = try Data(contentsOf: url)
                                cell.cellBgImageView.image = UIImage(data: realData)
                            }catch{
                            }
                        })
                    }
                }else if indexPath.row == 2 {
                    cell.rankingTitleTextLabel.text = "부산에서 즐기는 여름 전시"
                    cell.cellBgImageView.image = #imageLiteral(resourceName: "busan_low")
                    
                    DispatchQueue.main.async {
                        Storage.storage().reference().child("busan_high.jpg").downloadURL(completion: { (url, error) in
                            if let error = error {
                                print("error:\(error)")
                            }
                            
                            guard let url = url else {return}
                            
                            do{
                                let realData = try Data(contentsOf: url)
                                cell.cellBgImageView.image = UIImage(data: realData)
                            }catch{
                            }
                        })
                    }
                }
            }else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.rankingTitleTextLabel.text = "미술에 대해서"
                    cell.cellBgImageView.image = #imageLiteral(resourceName: "paint_low")
                    
                    DispatchQueue.main.async {
                        Storage.storage().reference().child("paint_high.jpg").downloadURL(completion: { (url, error) in
                            if let error = error {
                                print("error:\(error)")
                            }
                            
                            guard let url = url else {return}
                            
                            do{
                                let realData = try Data(contentsOf: url)
                                cell.cellBgImageView.image = UIImage(data: realData)
                            }catch{
                            }
                        })
                    }
                }else if indexPath.row == 1{
                    cell.rankingTitleTextLabel.text = "설치미술"
                    cell.cellBgImageView.image = #imageLiteral(resourceName: "installation_low")
                    
                    DispatchQueue.main.async {
                        Storage.storage().reference().child("installation_high.jpg").downloadURL(completion: { (url, error) in
                            if let error = error {
                                print("error:\(error)")
                            }
                            
                            guard let url = url else {return}
                            
                            do{
                                let realData = try Data(contentsOf: url)
                                cell.cellBgImageView.image = UIImage(data: realData)
                            }catch{
                            }
                        })
                    }
                }
            }else{
                cell.rankingTitleTextLabel.text = "땜빵"
            }
            
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
            
            switch section {
            case 0:
                return 3
            case 1:
                return 2
            case 2:
                return 2
            default:
                return 0
            }
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
            return 150
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if isBeginEditing {
            
        } else if isdidChangeText {
            
        } else if isSearchBtnClicked {
            
        } else {
            let rankingViewController:RankingViewController = storyboard?.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
            
            rankingViewController.sectionOfIndexPath = indexPath.section
            rankingViewController.rowOfIndexPath = indexPath.row
            
            self.navigationController?.pushViewController(rankingViewController, animated: true)
        }
        
    }
    
    func presentLoginVC(){
        if Auth.auth().currentUser == nil {
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }else{
            print(Auth.auth().currentUser?.email)
        }
    }
    
    
    /*******************************************/
    // MARK: -  Func                           //
    /*******************************************/
    
    func deleteSearchKeyword(){
        searchKeyword = []
        rankingTableView.reloadData()
    }
    
}
