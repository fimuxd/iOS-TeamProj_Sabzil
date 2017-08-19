//
//  HomeViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLoginVC()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmainTabelview), name: NSNotification.Name("dismissPopup"), object: nil)
        
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
        
        /*
         이거를 눌렀을때, 전시데이터의 like갯수가 올라가고,
         해당 유저의 좋아요목록에 이 전시id가 들어가고
         만약 이 전시 id를 검색해서 좋아요가 눌려있다면
         이미지뷰의 이미지가 tint바뀐다.
         다시 좋아요를 눌렀을때는, 전시데이터 like갯수가 줄어들고
         해당 유저의 좋아요 목록에서 이 전시 Id가 사라지며
         이 전시 id를 검색해 좋아요가 사라져있다면
         이미지뷰의 이미지가 노말로 바뀐다
         */
        
    }
    
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell

        cell.delegate = self

        var selectedExhibitionData:ExhibitionData?{
            didSet{
                guard let realExhibitionData = selectedExhibitionData else {
                    print("리얼데이터가 없습니다")
                    return
                }
                
                cell.mainTitleLabel.text = realExhibitionData.title
                cell.localLabel.text = realExhibitionData.district.rawValue
                cell.exhibitionTerm.text = "\(realExhibitionData.periodData[0].startDate)~\(realExhibitionData.periodData[0].endDate)"
                cell.museumName.text = realExhibitionData.placeData[0].address
                
                guard let url = URL(string: realExhibitionData.imgURL[0].posterURL) else {return}
                
                do{
                    let realData = try Data(contentsOf: url)
                    cell.mainPosterImg.image = UIImage(data: realData)
                }catch{
                    
                }
                
            }
        }
        
        DataCenter.sharedData.requestExhibitionData(id: indexPath.row) { (dic) in
            selectedExhibitionData = dic
        }
        
        /*
         cell.localLabel.text = "서울"
         cell.mainTitleLabel.text = "메인타이틀 텍스트 전시이름이들어갑니다"
         cell.exhibitionTerm.text = "2017. 07. 08~ 2017. 08. 09"
         cell.museumName.text = "디뮤지엄"
         */
        
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
        print("메인테이블뷰 리로드")
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
