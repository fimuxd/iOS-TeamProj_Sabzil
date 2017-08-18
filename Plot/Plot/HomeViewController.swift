//
//  HomeViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
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
        self.mainTableView.register(UINib.init(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
        
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
        
        return cell
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
    
}
