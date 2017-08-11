//
//  DataTestViewController.swift
//  Plot
//
//  Created by Bo-Young PARK on 7/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import UIKit

class DataTestViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func searchButtonAction(_ sender: UIButton) {
        guard let realIntText = self.inputTextField.text else {return}
        
        DataCenter.sharedData.getExhibitionData(id: realIntText)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
