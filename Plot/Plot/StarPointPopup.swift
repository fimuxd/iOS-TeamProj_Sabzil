//
//  StarPointPopup.swift
//  Plot
//
//  Created by joe on 2017. 8. 7..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

typealias popupHandler = ((StarPointPopup) -> Void)

class StarPointPopup:UIView {
    
    
    // MARK: - Property
    private var saveHandler:popupHandler = {(self) in }
    private var cancelHandler:popupHandler?
    //클로저 두개 만들어줌
    
    private let backgroundBlackout: UIView = UIView()
    private var movingDistance:CGFloat = UIScreen.main.bounds.height
    
    
    private func dismiss(){
        self.endEditing(true)
        print("dismiss")
    }
    
    
    // MARK: - Initialize
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame:CGRect, saveHandler: @escaping popupHandler, cancelHandler: popupHandler?){
        
        super.init(frame: frame)
        
//        self.saveHandler = saveHandler
//        self.cancelHandler = cancelHandler
        
        self.backgroundBlackout.backgroundColor = UIColor.black
        self.backgroundBlackout.alpha = 0.5
        self.movingDistance -= self.frame.origin.y
        
    }
    
    private func loadNib(on superView:UIView) {
        var rect:CGRect = superView.bounds
        rect.origin.y += 64.0
        rect.size.height -= 64.0
        self.backgroundBlackout.frame = rect
    }
    
}
