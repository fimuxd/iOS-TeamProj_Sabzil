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
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentLoginVC()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmainTabelview), name: NSNotification.Name("dismissPopup"), object: nil)

        self.mainTableView.register(UINib.init(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")
<<<<<<< HEAD
<<<<<<< HEAD

=======
        // Do any additional setup after loading the view.
    
>>>>>>> 2759a35c9835ddb45cc411dbd437f41d8383c045
=======
>>>>>>> f967244c9418675a460520f36b63e5b6e42e6ae6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> f967244c9418675a460520f36b63e5b6e42e6ae6
        
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
                    print("loading Image")
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
        
<<<<<<< HEAD
=======
        cell.delegate = self
        cell.selectionStyle = .none
        cell.localLabel.text = "서울"
        cell.mainTitleLabel.text = "전시제목"
        cell.exhibitionTerm.text = "전시기간"
        cell.museumName.text = "디뮤지엄"
>>>>>>> 2759a35c9835ddb45cc411dbd437f41d8383c045
=======
>>>>>>> f967244c9418675a460520f36b63e5b6e42e6ae6
        return cell
    }
    
    func isStarPointButtonClicked() {
        presentStarPointPopup()
    }
    
    func isCommentButtonClicked() {
        presentCommentPopup()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return Database.database().reference().child("ExhibitionData").accessibilityElementCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController:DetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    /*******************************************/
    // MARK: - Func                            //
    /*******************************************/
    
    func presentLoginVC(){
        if !UserDefaults.standard.bool(forKey: "LoginTest"){
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
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
