//
//  RecommendationViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    @IBOutlet weak var recommendTableView: UITableView!
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recommendTableView.delegate = self
        self.recommendTableView.dataSource = self
        self.recommendTableView.register(UINib(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")

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
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }


}
