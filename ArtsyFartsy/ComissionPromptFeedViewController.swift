////
////  ComissionPromptFeedViewController.swift
////  ArtsyFartsy
////
////  Created by REBEKKA GEEB on 4/4/19.
////  Copyright © 2019 MICHAEL BENTON. All rights reserved.
////
//
//import UIKit
//import Parse
//import AlamofireImage
//
//class ComissionPromptFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    //todo connect tableview outlet
//
//    //todo pull commission prompts from parse server
//
//    //Array of PFObjects, commission prompts
//    var commissionPrompts = [PFObject]()
////    var clickedCommissionPrompt: PFObject!  ??
//
//    //Refresh control
//    let commissionRefreshControl = UIRefreshControl()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        refreshComissionFeed()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        //Add keyboard dismiss?
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        //From parse documentation
//        let query = PFQuery(className: "Posts")
//        //Change order that posts will be in
//        query.order(byDescending: "CreatedAt")
//
//        query.includeKeys(["author", "comments", "comments.author"])
//        query.limit = 20
//
//        query.findObjectsInBackground{(posts, error) in
//            if posts != nil {
//                self.commissionPrompts = posts!
//                self.feedTableView.reloadData() //Fix tableview
//            }
//        }
//    }
//
//    //Refresh function
//    @objc func refreshComissionFeed(){
//        //Repopulate list of tweets
//        self.tableView.reloadData() //Fix tableview
//
//        //End the refresh
//        self.theRefreshControl.endRefreshing()
//    }
//
//    //Add hidden keyboard func?
//    //Add buttons, people can accept the request
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return commissionPrompts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkPostCell") as! ArtworkPostCell //Fix tableview
//
//        let commissionPrompt = commissionPrompts[indexPath.row]
//
//        let user = commissionPrompt["author"] as! PFUser
//
//        cell.usernameLabel.text = user.username
//
//        //Get commission string and display it
////        let imageFile = artworkPost["image"] as! PFFileObject
////        let urlString = imageFile.url!
////        let url = URL(string: urlString)!
////
////        cell.artworkImgView.af_setImage(withURL: url)
//
////        cell.commissionStringLabel.text = ...get from Parse!
//
//        return cell
//
//    }
//
//    //Add logout button??
//
//
//
//}
