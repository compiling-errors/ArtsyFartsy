//
//  OpenFollowedViewController.swift
//  ArtsyFartsy

//  Created by REBEKKA GEEB on 5/1/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.


import UIKit
import Parse
import AlamofireImage

class OpenFollowedViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreinfoLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var artworkImgView: UIImageView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    var individualUser: PFObject!
    
    let theRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display info about artwork
        nameLabel.text = individualUser?["name"] as? String
        moreinfoLabel.text = individualUser?["moreinfo"] as? String
        usernameLabel.text = individualUser?["authorUsername"] as? String

        //        Get image and display it
        let imageFile = individualUser["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        artworkImgView.af_setImage(withURL: url)
        
        print(individualUser)

        loadLikeCounter()

        showProfilePic()
    }

    func loadLikeCounter(){
        
        let x : Int = individualUser!.object(forKey: "likeCount") as! Int
        let xNSNumber = x as NSNumber
        let xString : String = xNSNumber.stringValue
        self.likesLabel.text = xString
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func likeButton(_ sender: Any) {
        // Get the objectId of the current artwork
        let imageId = individualUser?.objectId
        let currentUser = PFUser.current()?.username
        
        print("imageId = ", imageId!)
        
        //Add username into ArtworkPosts table, to "add a like"
        //Check if user has already clicked like
        
        
        let query = PFQuery(className:"ArtworkPosts")
        
        query.whereKey("objectId", equalTo:individualUser?.objectId!)
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
                        var x : Int = self.individualUser!.object(forKey: "likeCount") as! Int
                        x += 1
                        let xNSNumber = x as NSNumber
                        let xString : String = xNSNumber.stringValue
                        self.likesLabel.text = xString
                        
                        print("Like saved.")
                        
                       //Reload
                        
                    }
                }
            }
        }
    }
    
    @IBAction func unfollowButton(_ sender: Any) {
        
        //Ask user to confirm that they want to delete follow
        let alertController = UIAlertController(title: "Delete follow?", message: "Are you sure you want to unfollow this user?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete follow", style: .default) { (action) in
            
            let query = PFQuery(className: "Follow")
            query.whereKey("userBeingFollowedUsername", equalTo: self.individualUser?["authorUsername"] as! String)
            query.whereKey("userFollowing", equalTo: PFUser.current()!)
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print("Error, unable to unfollow user :" ,error.localizedDescription)
                    
                    let alertView = UIAlertView(
                        title: "Error",
                        message: "Unable to unfollow user. Please try again.",
                        delegate: nil,
                        cancelButtonTitle: "OK"
                    )
                    alertView.show()
                    
                } else if let objects = objects {
                    // The find succeeded.
                    print("Successfully unfollowed user.")
                    // Do something with the found objects
                    for object in objects {
                        object.deleteInBackground()
                    }
                    
                    //Show a success message to user
                    let alertView = UIAlertView(
                        title: "Follow Deleted",
                        message: "Successfully unfollowed user.",
                        delegate: nil,
                        cancelButtonTitle: "OK"
                    )
                    alertView.show()
                    
                    
                }
            }
        }
        //If user clicks cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //do nothing
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
        
    }
    
    func showProfilePic() {
        let theUsername = individualUser?["authorUsername"] as? String
        
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
                
                self.profileImgView.af_setImage(withURL: url)
                
        }
        
    }
    }

//    @IBOutlet var backButton: UIView!
//    let secondViewController:FollowingPageViewController = SecondViewController()
//
//    self.presentViewController(secondViewController, animated: true, completion: nil)

}
