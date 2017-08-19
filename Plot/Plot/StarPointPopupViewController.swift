//
//  StarPointPopupViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 18..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import HCSStarRatingView

class StarPointPopupViewController: UIViewController {

    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    
    @IBAction func tappedBlackOut(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBOutlet weak var starPointBottomConstranint: NSLayoutConstraint!
    
    
    @IBOutlet weak var starPointView: UIView!
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

            starPointBottomConstranint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let starRatingView:HCSStarRatingView = HCSStarRatingView.init(frame: CGRect(x: starPointView.frame.width / 2 - 120, y: 55, width: 240, height: 40))
        
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = 0
        starRatingView.tintColor = UIColor.cyan
        starRatingView.addTarget(self, action: #selector(changedValue), for: .valueChanged)
        
        starRatingView.allowsHalfStars = true
        starRatingView.emptyStarImage = #imageLiteral(resourceName: "nomal_star")
        starRatingView.halfStarImage = #imageLiteral(resourceName: "half_star")
        starRatingView.filledStarImage = #imageLiteral(resourceName: "tint_star")
        
        starPointView.addSubview(starRatingView)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.post(name: NSNotification.Name("dismissStarPopup"), object: self)
    }
    
    func changedValue(){
        print("별점주세여!!!!!")
    }

}
