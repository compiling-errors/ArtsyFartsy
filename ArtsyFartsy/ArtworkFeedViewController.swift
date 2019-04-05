//
//  ArtworkFeedViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/4/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ArtworkFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //todo Connect tableview, choose to add messageinputbar?
    
    //todo pull profile images, captions/descriptions from parse server

    //Array of PFObjects, artwork posts 
    var artworkPosts = [PFObject]()
    var clickedArtworkPost: PFObject!
    
    //Refresh feed
    let artworkRefreshControl = UIRefreshControl
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshArtworkFeed()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Dismiss keyboard by dragging down on tableview
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(hiddenKeyboard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        theRefreshControl.addTarget(self, action: #selector(refreshPhotoFeed), for: .valueChanged)
        self.tableView.refreshControl = artworkRefreshControl
    }
    
    //Refresh artwork feed
    @objc func refreshArtworkFeed(){
        //Repopulate list of tweets
        self.tableView.reloadData()
        
        //End the refresh
        self.artworkRefreshControl.endRefreshing()
    }
    
    //Hide keyboard
    @objc func hiddenKeyboard(note: Notification){
        commentBar.inputTextView.text = nil
        showMessageInputBar = false
        becomeFirstResponder()
    }
    
    //Refresh tableview here
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //From parse documentation
        let query = PFQuery(className: "artworkPosts")
        //Change order that posts will be in
        query.order(byDescending: "uploadDate")
        
        query.includeKeys(["author"])
        query.limit = 20
        
        query.findObjectsInBackground{(artworkPosts, error) in
            if posts != nil {
                self.artworkPosts = artworkPosts!
                self.tableView.reloadData()
            }
        }
    }
    
    //Reload feed
    tableView.reloadData()
    
    //Mandatory functions for rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            let post = posts[section]
            //Nil coalescing operator ??
            //If statement is nil handles
            let comments = (post["comments"] as? [PFObject]) ?? []
            
            //Comment and add comment cell
            return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    //Add identifier for cell to storyboard: "ArtworkCell"
    //Make sure identifiers match
    //Change url lines
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artworkPost = artworkPosts[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkCell") as! ArtworkCell
            
            let user = artworkPost["author"] as! PFUser
            
            cell.usernameLabel.text = user.username
            
            cell.captionLabel.text = (post["caption"] as! String)
            
            //Get image and display it above caption
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.photoView.af_setImage(withURL: url)
            
            return cell
        
        //Took out commentcell code
            
    }
    
        //todo must autocreate likes/favorites etc on parse server
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let artworkPost = artworkPosts[indexPath.section]
            
            //Will autocreate on server
            let likes = (artworkPost["likes"] as? [PFObject]) ?? []
            
            if indexPath.row == likes.count + 1 {
                //....need to figure out what we are using for likes, regular button??
                //showMessageInputBar = true
                //becomeFirstResponder()
                
                //commentBar.inputTextView.becomeFirstResponder()
                
                clickedArworkPost = artworkPost
                
            }
            
        }
        


}
