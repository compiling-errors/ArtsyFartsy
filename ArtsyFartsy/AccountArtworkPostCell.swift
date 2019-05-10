//
//  AccountArtworkPostCell.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/24/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit

class AccountArtworkPostCell: UITableViewCell {
    
    @IBOutlet weak var accountArtworkImgView: UIImageView!
    
    @IBOutlet weak var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
