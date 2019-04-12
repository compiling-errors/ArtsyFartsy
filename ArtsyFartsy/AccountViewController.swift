////
////  AccountViewController.swift
////  ArtsyFartsy
////
////  Created by REBEKKA GEEB on 4/11/19.
////  Copyright © 2019 MICHAEL BENTON. All rights reserved.
////
//
//import UIKit
//import Parse
//import AlamofireImage
//
//class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    //todo make top of account page screen, get username with parse, default profile pic?
//              //whereKeyDoesNotExist?
//
//    //account tableview of user's previous posts
//
//    var userArtworkPosts = [PFObject]()
//
//    //put outlet for tableview
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //fix tableview after connecting
//        feedTableView.delegate = self
//        feedTableView.dataSource = self
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
//                self.userArtworkPosts = posts!
//
//                //fix tableview after connecting
//                self.feedTableView.reloadData()
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return artworkPosts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkPostCell") as! ArtworkPostCell //make connection then change
//
//        let userArtworkPosts = userArtworkPosts[indexPath.row]
//
//        let user = userArtworkPost["author"] as! PFUser
//
//        cell.usernameLabel.text = user.username
//
//        //Get image and display it
//        let imageFile = userArtworkPost["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.artworkImgView.af_setImage(withURL: url)//change image view once connected
//
//        return cell
//
//    }
//
//    //connect logout button
////    {
////    PFUser.logOut()
////
////    let main = UIStoryboard(name: "Main", bundle: nil)
////    let loginPageViewController = main.instantiateViewController(withIdentifier: "LoginPageViewController")
////
////    //Access the delegate for use
////    let delegate = UIApplication.shared.delegate as! AppDelegate
////
////    delegate.window?.rootViewController = loginPageViewController
////    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
