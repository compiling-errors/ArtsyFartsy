//
//  FollowingPageViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/30/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FollowingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usersFollowedPFObject = [PFObject]()
    var followingFeedPFObjectToBeDisplayed = [PFObject]()
    
    
    
    let theRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Refresh feed
//        refreshArtworkFeed()
        self.usersFollowedPFObject = [PFObject]()
        self.followingFeedPFObjectToBeDisplayed = [PFObject]()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        theRefreshControl.addTarget(self, action: #selector(refreshArtworkFeed), for: .valueChanged)
        self.tableView.refreshControl = theRefreshControl

        queryTables()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    fileprivate func queryTables() {
        //Query for getting usernames of users being followed
        let query = PFQuery(className: "Follow")
        //origonal before testing
        //        query.whereKey("userFollowing", contains: PFUser.current()?.username)
        query.whereKey("userFollowing", contains: PFUser.current()?.objectId)
        
        //Change order that posts will be in
        query.order(byDescending: "createdAt")
        
        query.includeKey("userBeingFollowedUsername")
        query.limit = 999
        
        query.findObjectsInBackground{ (followed, error) in
            if followed != nil {
                self.usersFollowedPFObject = followed!
                
                for individualUser in followed! {
                    
                    let usertest = individualUser["userBeingFollowedObjectId"]
                    //Username is the username string retrieved from individualUser
                    let userObjectId = usertest! as! String
                    
                    //From parse documentation
                    let query = PFQuery(className: "ArtworkPosts")
                    //Change order that posts will be in
                    query.order(byDescending: "createdAt")
                    //                query.includeKey("author")
                    //                query.limit = 20
                    query.whereKey("authorId", equalTo: userObjectId)
                    query.getFirstObjectInBackground{ (object, error) in
                        if object != nil {
                            if self.followingFeedPFObjectToBeDisplayed.count <= (followed?.count)! {
                                self.followingFeedPFObjectToBeDisplayed.append(object!)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingFeedPFObjectToBeDisplayed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPageCell") as! FollowingPageCell

//        let followed = usersFollowedPFObject[indexPath.row]

        let followed2 = followingFeedPFObjectToBeDisplayed[indexPath.row]
        
        //Get and display followed user's username
        let usertest = followed2["authorUsername"] as! String
        
        cell.usernameLabel.text = usertest
        
        //        individualUser is pfobject, takes each individual pfobject inside followed
        
        
//        Get image and display it
        let imageFile = followed2["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        cell.followedArtworkImgView.af_setImage(withURL: url)

        return cell
        
    }
    
    @objc func refreshArtworkFeed(){
        self.usersFollowedPFObject = [PFObject]()
        self.followingFeedPFObjectToBeDisplayed = [PFObject]()
        queryTables()
        //Repopulate list of tweets
        self.tableView.reloadData()
        //End the refresh
        self.theRefreshControl.endRefreshing()
    }
    

    //Send data to OpenArtworkViewController to view larger version of user artwork

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        print("Opening followed user most recent artwork screen.")

        //Get selected followed user most recent artwork
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let followedUser = followingFeedPFObjectToBeDisplayed[indexPath.row]

        //Pass information to OpenFollowedViewController
        let followedViewController = segue.destination as! OpenFollowedViewController

        followedViewController.individualUser = followedUser

        //Deselect cell manually
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
}

