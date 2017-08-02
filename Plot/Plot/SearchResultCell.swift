//
//  SearchResultCell.swift
//  Plot
//
//  Created by joe on 2017. 8. 3..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var exhiPoster: UIImageView!
    @IBOutlet weak var exhiTitle: UILabel!
    @IBOutlet weak var exhiSubtitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
