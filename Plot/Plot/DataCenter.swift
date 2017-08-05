//
//  DataCenter.swift
//  Plot
//
//  Created by Bo-Young PARK on 1/8/2017.
//  Copyright © 2017 joe. All rights reserved.
//

import Foundation

class DataCenter {
    static let default:DataCenter = DataCenter()
    
    private var userDatas:[UserData]!
    private var exhibitDatas:[ExhibitionData]!
    
    var userDataList:[UserData] {
        get {
            return userDataArray
        }
    }
    
    var exhibitList:[ExhibitionData] {
        get {
            return exhibitDataArray
        }
    }
    
    private init() {
        loadFromBundle()
    }
    
    private func loadFromBundle() {
        let bundlePath:String = Bundle.main.path(forResource: )
    }
}
