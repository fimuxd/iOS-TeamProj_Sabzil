//
//  HomeViewController.swift
//  Plot
//
//  Created by joe on 2017. 7. 31..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

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
        self.mainTableView.register(UINib.init(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")
        // Do any additional setup after loading the view.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.localLabel.text = "서울"
        cell.mainTitleLabel.text = "전시제목"
        cell.exhibitionTerm.text = "전시기간"
        cell.museumName.text = "디뮤지엄"
        return cell
    }
    
    func isStarPointButtonClicked() {
        presentStarPointPopup()
    }
    
    func isCommentButtonClicked() {
        presentCommentPopup()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
    
    func presentStarPointPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        popup.senderTag = 1
        present(popup, animated: true, completion: nil)
    }
    
    func presentCommentPopup(){
        let popup = storyboard?.instantiateViewController(withIdentifier: "Popup") as! Popup
        popup.senderTag = 2
        present(popup, animated: true, completion: nil)
    }
}
