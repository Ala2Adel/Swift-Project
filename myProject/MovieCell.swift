//
//  MovieCell.swift
//  myProject
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 JETS. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

//    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
