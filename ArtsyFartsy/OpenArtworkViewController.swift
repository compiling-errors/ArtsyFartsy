//
//  OpenArtworkViewController.swift
//  ArtsyFartsy
//
//  Created by Tiny on 4/22/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class OpenArtworkViewController: UIViewController {
    
    //Create variable to save individual user artwork
    var artwork: PFObject?
    
    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreinfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = artwork?["author"] as! PFUser

        // Do any additional setup after loading the view.
        print(artwork?["name"])
        print("author", user.username)
        
        //Display info about artwork
        nameLabel.text = artwork?["name"] as? String
        moreinfoLabel.text = artwork?["moreinfo"] as? String
        usernameLabel.text = user.username
        
        //Display artwork image
        let imageFile = artwork?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        artworkImgView.af_setImage(withURL: url)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        let query = PFQuery(className: "ArtworkPosts")
        
        
        
    }
    
    @IBAction func likeButton(_ sender: Any) {
    }
    
    
    @IBAction func followButton(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
