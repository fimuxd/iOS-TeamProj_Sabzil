//
//  SearchResultCell.swift
//  Plot
//
//  Created by joe on 2017. 8. 3..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class SearchResultCell: UITableViewCell {
    
    
    /*******************************************/
    // MARK: -  Outlet                         //
    /*******************************************/
    
    @IBOutlet weak var exhiPoster: UIImageView!
    @IBOutlet weak var exhiTitle: UILabel!
    @IBOutlet weak var exhiSubtitle: UILabel!
    
    var exhibitionID:Int?
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /*******************************************/
    // MARK: -  LifeCycle                      //
    /*******************************************/
    
    func getExhibitionInfo(exhibitionID:Int) {
        
        Database.database().reference().child("ExhibitionData").child("\(exhibitionID)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [String:Any] else { return }
            
            guard let titleString = json[Constants.exhibition_Title] as? String else { return }
            self.exhiTitle.text! = titleString
            
            guard let placeData = json[Constants.exhibition_PlaceData] as? [String:String],
                let exhibitionPlace:String = placeData[Constants.place_Address] else { return }
            self.exhiSubtitle.text! = exhibitionPlace
            
            guard let imageData = json[Constants.exhibition_ImgURL] as? [String:String],
                let posterImage:String = imageData[Constants.image_PosterURL] else { return }
            
            guard let url = URL(string: posterImage) else { return }
            do {
                let realData = try Data(contentsOf: url)
                self.exhiPoster.image = UIImage(data: realData)
            }catch {
                // MARK: - 여기 두캐치 잘모르게뜨
            }
            print(url)
            print("\(exhibitionID)","로딩되나여==========================================")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
