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
    
    var databaseReference:DatabaseReference!
    var exhibitionData:ExhibitionData?
    var userData:UserData?
    
    
    //    var isLogin:Bool = false
    //    var userData:UserData?
    //    private func requestIsLogin() -> Bool {
    //        if Auth.auth().currentUser == nil {
    //            isLogin = false
    //            return false
    //        }else{
    //            isLogin = true
    //            return true
    //        }
    //    }
    //
    //    private func requestUserData(completion:@escaping (_ info:UserData) -> Void) {
    //        guard let uid = Auth.auth().currentUser?.uid else {return}
    //
    //        Database.database().reference().child(uid).observeSingleEvent(of: .value, with: { (snapShot) in
    //            let dic = snapShot.value as! [String:Any]
    //            completion(UserData.init(dictionary: dic))
    //        })
    //    }
    
    func getExhibitionData(id:Int) {
        
        /* Firebase 문서 예제
         [데이터 한번 읽기]
         한 번만 호출되고 즉시 삭제되는 콜백이 필요한 경우가 있습니다. 이후에 변경되지 않는 UI 요소를 초기화할 때가 그 예입니다. 이러한 경우 observeSingleEventOfType 메소드를 사용하면 시나리오가 단순해집니다. 이렇게 추가된 이벤트 콜백은 한 번 호출된 후 다시 호출되지 않습니다.
         
         이 방법은 한 번 로드된 후 자주 변경되지 않거나 능동적으로 수신 대기할 필요가 없는 데이터에 유용합니다. 예를 들어 위 예제의 블로깅 앱에서는 사용자가 새 게시물을 작성하기 시작할 때 이 메소드로 사용자의 프로필을 로드합니다.
         
         let userID = FIRAuth.auth()?.currentUser?.uid
         ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
         // Get user value
         let username = snapshot.value!["username"] as! String
         let user = User.init(username: username)
         
         // ...
         }) { (error) in
         print(error.localizedDescription)
         }
         
         */

        var sellectedExhibitionRef:DatabaseReference = self.databaseReference.child("ExhibitionData")
        
        sellectedExhibitionRef.child("0").observeSingleEvent(of: .value, with: { (snapshot) in
            //ExhibitionData 를 가져옵니다. 
            let selectedExhibitionData = snapshot.value!["exhibition_Title"] as! String
        }) { (error) in
            print(error.localizedDescription)
        }
        
//        print(sellectedExhibitionData)
        
        
    }
}

