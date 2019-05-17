//
//  ArtworkPostCell.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/4/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import AlamofireImage

class ArtworkPostCell: UITableViewCell {


    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nounLabel: UILabel!
    @IBOutlet weak var adjectiveLabel: UILabel!
    @IBOutlet weak var verbLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let size = CGSize(width: 396, height: 296)
        let scaledImage = artworkImgView.image?.af_imageAspectScaled(toFill: size)
        
        artworkImgView.image = scaledImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*func showProfilePic() {
        let theUsername = PFUser.current()?.username
        
        let query = PFQuery(className: "profilePictures")
        
        query.whereKey("username", equalTo: theUsername!)
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query succeeded but no matching result was found
                print("No profile pic found")
                
                
            } else if let object = object {
                // The find succeeded.
                print("Loaded profile pic.")
                
                let imageFile = object["profilePic"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                self.profilePicImgView.af_setImage(withURL: url)
                
            }
            
        }
    }*/

}

/*
 let artworkPost = PFObject(className: "ArtworkPosts")
 
 //Create dictionary
 //If you add stuff later, things will be nil: must handle this or delete table and start over again
 artworkPost["name"] = self.artworkName.text!
 artworkPost["moreinfo"] = self.artworkMoreInfo.text!
 artworkPost["author"] = PFUser.current()!
 artworkPost["authorUsername"] = PFUser.current()!.username!
 artworkPost["authorId"] = PFUser.current()!.objectId!
 artworkPost["likeCount"] = 0
 artworkPost["nounOfDay"] = self.nounLabel.text!
 artworkPost["verbOfDay"] = self.nounLabel.text!
 artworkPost["adjectiveOfDay"] = self.nounLabel.text!
 */
