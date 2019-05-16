//
//  ArtworkFeedViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/10/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ArtworkFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var artworkPosts = [PFObject]()
    
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
        
        //From parse documentation
        let query = PFQuery(className: "ArtworkPosts")
        
        //Change order that posts will be in
        query.order(byDescending: "createdAt")
        
        query.includeKey("author")
        query.includeKey("likeCount")
        query.includeKey("name")
        query.includeKey("moreinfo")
        query.includeKey("nounOfDay")
        query.includeKey("adjectiveOfDay")
        query.includeKey("verbOfDay")
        query.limit = 999
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.artworkPosts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworkPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkPostCell") as! ArtworkPostCell
        
        let artworkPost = artworkPosts[indexPath.row]
        
        let user = artworkPost["author"] as! PFUser
        let likeLabel = artworkPost["likeCount"]
        let artworkname = artworkPost["name"]
        let caption = artworkPost["moreinfo"]
        let noun = artworkPost["nounOfDay"]
        let adjective = artworkPost["adjectiveOfDay"]
        let verb = artworkPost["verbOfDay"]
        
        
        cell.usernameLabel.text = user.username
        cell.likeLabel.text = likeLabel as? String
        cell.titleLabel.text = artworkname as? String
        cell.captionLabel.text = caption as? String
        cell.nounLabel.text = noun as? String
        cell.adjectiveLabel.text = adjective as? String
        cell.verbLabel.text = verb as? String
        
        //Get image and display it
        let imageFile = artworkPost["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        cell.artworkImgView.af_setImage(withURL: url)
        /*
        let imageFile = artworkPost["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        */
        
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
        let artwork = artworkPosts[indexPath.row]
        
        //Pass information to OpenArtworkViewController
        let individualArtworkViewController = segue.destination as! OpenArtworkViewController
        
        individualArtworkViewController.artwork = artwork
        
        //Deselect cell manually
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
