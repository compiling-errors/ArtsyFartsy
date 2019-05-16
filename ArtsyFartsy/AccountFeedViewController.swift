//
//  AccountFeedViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/24/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AccountFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var currentUsernameLabel: UILabel!
    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var profilePicImgView: UIImageView!
    
    var userArtworkPosts = [PFObject]()
    
    let theRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showUsername()
        
        //Refresh feed
        refreshArtworkFeed()
        
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        theRefreshControl.addTarget(self, action: #selector(refreshArtworkFeed), for: .valueChanged)
        self.accountTableView.refreshControl = theRefreshControl
        
        showProfilePic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        let query = PFQuery(className: "ArtworkPosts")
        query.whereKey("author", equalTo: PFUser.current()!)
        
        //Change order that posts will be in
        query.order(byDescending: "createdAt")
        
        query.includeKey("author")
        query.limit = 999
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.userArtworkPosts = posts!
                self.accountTableView.reloadData()
            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArtworkPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountArtworkPostCell") as! AccountArtworkPostCell
        
        let artworkPost = userArtworkPosts[indexPath.row]
        
        let user = artworkPost["author"] as! PFUser
        
        //Get image and display it
        let imageFile = artworkPost["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.accountArtworkImgView.af_setImage(withURL: url)
        
        //Convert the date saved in createdAt to a string, so it can be printed
        let createdAtToString = DateFormatter()
        createdAtToString.locale = Locale(identifier: "createdAt")
        createdAtToString.dateFormat = "MM-dd-YY"
        
        cell.postDateLabel.text = createdAtToString.string(from: artworkPost.createdAt!)
        
        return cell
        
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginPageViewController = main.instantiateViewController(withIdentifier: "LoginPageViewController")
        
        //Access the delegate for use
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginPageViewController
    }
    
    @objc func refreshArtworkFeed(){
        //Repopulate list of tweets
        self.accountTableView.reloadData()
        
        //End the refresh
        self.theRefreshControl.endRefreshing()
    }
    
    func showUsername() {
        currentUsernameLabel.text = PFUser.current()?.username
    }
    
    
    //Send data to OpenArtworkViewController to view larger version of user artwork
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    @IBAction func tapToChangeProfilePic(_ sender: Any) {
        let artworkPicker = UIImagePickerController()
        artworkPicker.delegate = self
        artworkPicker.allowsEditing = true
        
        //Uses camera on regular phone, or photolibrary for simulator, prevent crash
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            artworkPicker.sourceType = .camera
        } else {
            artworkPicker.sourceType = .photoLibrary
        }
        
        present(artworkPicker, animated: true, completion: nil)
    }
    
    //Have user be able to pick photo from camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        //Resize photo
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profilePicImgView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if self.profilePicImgView.image == nil {
            let alertView = UIAlertView(
                title: "Error!",
                message: "Error! Must select a picture to save. Please try again.",
                delegate: nil,
                cancelButtonTitle: "OK"
            )
            alertView.show()
            
        } else {
            
            let alertController = UIAlertController(title: "Save picture?", message: "Save this as your public profile picture?", preferredStyle: .alert)
            
            let postAction = UIAlertAction(title: "Save", style: .default) { (action) in
                print("buttonrunning")
                
                let query = PFQuery(className:"profilePictures")
                
                query.whereKey("username", equalTo: PFUser.current()!.username!)
                
                query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
                    if let error = error {
                        // The query succeeded but no matching result was found
                        
                        //Create new object
                        let profilePic = PFObject(className: "profilePictures")
                        
                        //Create dictionary
                        //If you add stuff later, things will be nil: must handle this or delete table and start over again
                        profilePic["username"] = PFUser.current()!.username!
                        
                        
                        //Saved in a separate table for my photos
                        let imageData = self.profilePicImgView.image!.pngData()
                        let file = PFFileObject(data: imageData!)
                        
                        //This column has url
                        profilePic["profilePic"] = file
                        
                        profilePic.saveInBackground { (success, error) in
                            if success{
                                print("Saved profile pic!")
                                
                                //Show a success message to user
                                let alertView = UIAlertView(
                                    title: "Saved",
                                    message: "Success! New profile picture saved.",
                                    delegate: nil,
                                    cancelButtonTitle: "OK"
                                )
                                alertView.show()
                                
                                //  self.profilePicImgView.image = file
                            } else {
                                print("Error! Unable to save profile pic.")
                                
                                //Show an error message to user
                                let alertView = UIAlertView(
                                    title: "Error",
                                    message: "Unable to save new profile picture. Please try again.",
                                    delegate: nil,
                                    cancelButtonTitle: "OK"
                                )
                                alertView.show()
                            }
                            
                        }
                        
                    } else if let object = object {
                        //update the existing entry with the new picture
                        //Saved in a separate table for my photos
                        let imageData = self.profilePicImgView.image!.pngData()
                        let file = PFFileObject(data: imageData!)
                        
                        object["profilePic"] = file
                        
                        object.saveInBackground()
                        
                        print("Updated profile pic")
                        
                        let alertView = UIAlertView(
                            title:"Saved",
                            message:"Success! New profile picture saved.",
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
            alertController.addAction(postAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true)
            
            
        }
    }
    
    func showProfilePic() {
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
    }
}
