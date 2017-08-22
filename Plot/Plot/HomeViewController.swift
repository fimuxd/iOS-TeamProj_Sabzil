//
//  HomeViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, customCellDelegate {
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let exhibitionDatasRef = Database.database().reference().child("ExhibitionData")
    var exhibitionDataCount:Int = 0
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTableView.register(UINib.init(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")
        
        awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLoginVC()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmainTabelview), name: NSNotification.Name("dismissPopup"), object: nil) //디스미스팝업 되면 여기 있는 리로드테이블뷰 함수를 뷰디드로드할 때 실행시켜
        
        //--보영: 전시 데이터 가져오고 실시간 반영하기
        exhibitionDatasRef.keepSynced(true)
        
        self.exhibitionDatasRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.exhibitionDataCount = Int(snapshot.childrenCount)
            
            self.mainTableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.exhibitionDatasRef.observe(.childChanged, with: { (snapshot) in
            self.exhibitionDataCount = Int(snapshot.childrenCount)
            self.mainTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*******************************************/
    // MARK: -  CustomCell Delegate Method     //
    /*******************************************/
    
    func isStarPointButtonClicked() {
        presentStarPointPopup()
    }
    
    func isCommentButtonClicked() {
        presentCommentPopup()
    }
    
    func isLikeButtonClicked() {
        self.mainTableView.reloadData()
    }
    
    func reloadMainTableView() {
        self.mainTableView.reloadData()
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
        cell.selectionStyle = .none
        cell.delegate = self
        
        cell.loadLikeData(rowOfIndexPath: indexPath.row)
        cell.loadExbibitionData(rowOfIndexPath: indexPath.row)
        cell.indexPathRow = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exhibitionDataCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController:DetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailViewController.exhibitionID = indexPath.row
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    /*******************************************/
    // MARK: - Func                            //
    /*******************************************/
    
    func presentLoginVC(){
        if Auth.auth().currentUser == nil {
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }else{
            print(Auth.auth().currentUser?.email)
        }
    }
    
    func reloadmainTabelview(){
        self.mainTableView.reloadData()
    }
    
    
    func presentCommentPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        present(popup, animated: true, completion: nil)
    }
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "StarPointPopup") as! StarPointPopupViewController
        present(popup, animated: true, completion: nil)
        
    }
}
