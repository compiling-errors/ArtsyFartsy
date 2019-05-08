//
//  FollowingPageCell.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/30/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit

class FollowingPageCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followedArtworkImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
