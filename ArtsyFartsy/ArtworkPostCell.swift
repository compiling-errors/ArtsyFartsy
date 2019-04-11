//
//  ArtworkPostCell.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/4/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit

class ArtworkPostCell: UITableViewCell {


    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
