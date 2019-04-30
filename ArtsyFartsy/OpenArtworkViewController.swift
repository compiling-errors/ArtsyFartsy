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
    
    let artworkPost = PFObject(className: "ArtworkPosts")
    
    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreinfoLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declare user of current displayed artwork
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
        
        //Load in likes
        loadLikeCounter()
        
    }
    
    func loadLikeCounter(){
        
        let query = PFQuery(className:"ArtworkPosts")
    
        query.getObjectInBackground(withId: (artwork?.objectId)!) { (tempCount: PFObject?, error: Error?) in
            if let error = error {
                //The query returned an error
                print(error.localizedDescription)
            } else {
                //The object has been retrieved
                let stringstuff = tempCount!.object(forKey: "name")
                
                let x : Int = tempCount!.object(forKey: "likeCount") as! Int
                let xNSNumber = x as NSNumber
                let xString : String = xNSNumber.stringValue
                self.likesLabel.text = xString
            }
        }
}

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        
        
        
    }
    
    @IBAction func likeButton(_ sender: Any) {
        // Get the objectId of the current artwork
        let imageId = artwork?.objectId
        let currentUser = PFUser.current()?.username
        
        print("imageId = ", imageId!)
        
        //Add username into ArtworkPosts table, to "add a like"
                //Check if user has already clicked like
        
        
        let query = PFQuery(className:"ArtworkPosts")
        
        query.whereKey("objectId", equalTo:artwork?.objectId!)
        query.whereKey("usersClickedLike", equalTo:currentUser!)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query succeeded but no matching result was found
                let query = PFQuery(className:"ArtworkPosts")
                query.getObjectInBackground(withId: imageId!) { (userClickedLike: PFObject?, error: Error?) in
                    if let error = error {
                        print("Error, like was not saved.", error.localizedDescription)
                    } else if let userClickedLike = userClickedLike {
                        userClickedLike.addUniqueObjects(from: [PFUser.current()?.username], forKey:"usersClickedLike")
                        
                        userClickedLike.saveInBackground()
                        userClickedLike.incrementKey("likeCount")
                        userClickedLike.saveInBackground()                        //Save the new like to the likeCount column
                        print("Like saved.")
                        
                        self.loadLikeCounter()
                        
                        //Calculate and display likes on open artwork screen
                    }
                }
                
            }
                
            
        }
        
        
    }
    
    
  
    
    @IBAction func followButton(_ sender: Any) {
        print("Follow button clicked.")
        
        //Declare user of current displayed artwork, for use in follow button
        let usertest = artwork?["author"] as! PFUser
        let authorUsername1 = usertest.username!
        print(authorUsername1)


//        artwork?.object(forKey: "author") as? String
        let currentUser = PFUser.current()
        //Add username into ArtworkPosts table, to "add a like"
        //Check if user has already clicked like
        print("user id:", currentUser?.objectId)
        
//        query user table author = artworkauthor
        let objectId1 = usertest.objectId!
        print(objectId1)
        // suppose we have a user we want to follow
        
            /////////////////////////////////////////////////////////
        let query = PFQuery(className:"Follow")
        query.whereKey("userBeingFollowed", equalTo:authorUsername1)
        query.whereKey("userFollowing", equalTo: PFUser.current()!.username!)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error != nil {
                // Log details of the failure
                
            } else if let objects = objects{
                print("test if empty" ,objects.isEmpty)
                if objects.isEmpty{
                    // create an entry in the Follow table
                    let follow = PFObject(className: "Follow")
                    follow.setObject(PFUser.current()!.username!, forKey: "userFollowing")
                    follow.setObject(authorUsername1, forKey: "userBeingFollowed")
                    follow.saveInBackground()
                }
                // The find succeeded.
                print("User already following")
                // Do something with the found objects
            }
        }
        // suppose we have a user we want to follow

        
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
