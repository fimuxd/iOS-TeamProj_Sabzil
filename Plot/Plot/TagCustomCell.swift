//
//  TagCustomCell.swift
//  Plot
//
//  Created by joe on 2017. 8. 3..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit

class TagCustomCell: UICollectionViewCell {

    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1).cgColor
    }
    

    }


