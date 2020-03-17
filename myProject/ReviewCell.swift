//
//  ReviewCell.swift
//  myProject
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 JETS. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    
    @IBOutlet weak var authorLabel3: UILabel!
    

    @IBOutlet weak var contactLabel3: UILabel!
    
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
