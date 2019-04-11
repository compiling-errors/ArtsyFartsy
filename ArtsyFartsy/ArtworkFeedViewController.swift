//
//  ArtworkFeedViewController.swift
//  ArtsyFartsy
//
//  Created by Tiny on 4/10/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ArtworkFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var artworkPosts = [PFObject]()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        let query = PFQuery(className: "Posts")
        //Change order that posts will be in
        query.order(byDescending: "CreatedAt")
        
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground{(posts, error) in
            if posts != nil {
                self.artworkPosts = posts!
                self.feedTableView.reloadData()
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
        
        cell.usernameLabel.text = user.username
        
        //Get image and display it 
        let imageFile = artworkPost["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.artworkImgView.af_setImage(withURL: url)
        
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
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
