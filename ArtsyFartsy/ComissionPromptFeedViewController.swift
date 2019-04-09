////
////  ComissionPromptFeedViewController.swift
////  ArtsyFartsy
////
////  Created by REBEKKA GEEB on 4/4/19.
////  Copyright © 2019 MICHAEL BENTON. All rights reserved.
////
//
//import UIKit
//
//class ComissionPromptFeedViewController: UIViewController {
//
//    //todo connect tableview outlet
//
//    //todo pull commission prompts from parse server
//
//    //Array of PFObjects, commission prompts
//    var commissionPrompts = [PFObject]()
//    var clickedCommissionPrompt: PFObject!
//
//     //todo figure out logout button, set on other screens
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
//    //Refresh function
//    @objc func refreshComissionFeed(){
//        //Repopulate list of tweets
//        self.tableView.reloadData()
//
//        //End the refresh
//        self.theRefreshControl.endRefreshing()
//    }
//
//    //Add hidden keyboard func?
//    //Add message input bar?
//
//    //Get commission prompts
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
//        Int {
//            let commissionPrompts = prompts[section]
//
//            //todo optional comments? likes/favorites?
////            //If statement is nil handles
////            let comments = (post["comments"] as? [PFObject]) ?? []
////
////            //Comment and add comment cell
////            return comments.count + 2
//    }
//
//
//
//}
