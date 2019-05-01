//
//  FollowingPageViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/30/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FollowingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var following = [PFObject]()
    
    let theRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Refresh feed
        refreshArtworkFeed()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        theRefreshControl.addTarget(self, action: #selector(refreshArtworkFeed), for: .valueChanged)
        self.tableView.refreshControl = theRefreshControl
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Follow")
        query.whereKey("userFollowing", contains: PFUser.current()?.username)
        
        //Change order that posts will be in
        query.order(byDescending: "createdAt")
        
        query.includeKey("userBeingFollowed")
        query.limit = 20
        
        query.findObjectsInBackground{ (followed, error) in
            if followed != nil {
                self.following = followed!
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPageCell") as! FollowingPageCell
        
        let followed = following[indexPath.row]
        
        //Get and display followed user's username
        let usertest = followed["userBeingFollowed"] as! String
        
        cell.usernameLabel.text = usertest
        
//        //Get image and display it
//        let imageFile = followed["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.followedArtworkImgView.af_setImage(withURL: url)
        
        return cell
        
    }
    
    @objc func refreshArtworkFeed(){
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
        
        print("Opening user individual artwork screen.")
        
        //Get selected user individual artwork
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let artwork = following[indexPath.row]
        
        //Pass information to OpenArtworkViewController
        let individualArtworkViewController = segue.destination as! OpenArtworkViewController
        
        individualArtworkViewController.artwork = artwork
        
        //Deselect cell manually
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
