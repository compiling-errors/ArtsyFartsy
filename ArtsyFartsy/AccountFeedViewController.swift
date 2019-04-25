//
//  AccountFeedViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/24/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AccountFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var currentUsernameLabel: UILabel!
    
    @IBOutlet weak var accountTableView: UITableView!
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        let query = PFQuery(className: "ArtworkPosts")
        query.whereKey("author", equalTo: PFUser.current()!)
        
        //Change order that posts will be in
        query.order(byDescending: "createdAt")
        
        query.includeKey("author")
        query.limit = 20
        
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
    
    
}

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

