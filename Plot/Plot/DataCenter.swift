//
//  DataCenter.swift
//  Plot
//
//  Created by Bo-Young PARK on 1/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import Foundation
import Firebase

class DataCenter {
    static let sharedData = DataCenter()
    
    var isLogin:Bool = false
    var userData:UserData?
    var exhibitionData:ExibitionData?
    
    private func requestIsLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            isLogin = false
            return false
        }else{
            isLogin = true
            return true
        }
    }
    
    private func requestUserData(completion:@escaping (_ info:UserData) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child(uid).observeSingleEvent(of: .value) { (snapShot) in
            let dic = snapShot.value as! [String:Any]
            completion(UserData)
        }
                   }
    }
}
