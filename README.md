https://hackmd.io/B6U3hn3cQC-h_YGBsA_4Hg?both#Wireframes

Group Project - Compiling Errors
===

# Artsy Prompts

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app gives a daily drawing prompt, and allows user artwork to be uploaded, shared, and commented on.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**Art / Social Networking
- **Mobile:**The primary function of this app is to run on iOS devices. Thus, the artwork images would be best viewed from a mobile device. With postings made in real-time and images uploaded directly from a mobile camera, this interface is specifically formatted for the average mobile user. A separate, optimal interface can be created for computer usage.
- **Story:**A new prompt is given daily for the purpose of encouraging the user to create, post, and share personal artwork. The drawing feed allows for messaging between other users. Like many other social media sites, daily updated material and a platform to chat with other users encourages frequent use.
- **Market:**This app may interest any casual phone app user, to pass time and interact with other users, or hardcore artists who wish to promote their work.
- **Habit:**With a new daily drawing prompt, this app encourages daily access to post, view, and comment on new artwork.
- **Scope:**This app will serve as a general platform to encourage sharing and commenting on artwork. This idea is centered around an artwork feed, with the potential to continue adding many optional features. Possible updates could include monetization to allow users to purchase custom artwork or products for sale by the artist. Additional chatting/friends list features can also be added to allow for a more user friendly chat interface. However, these optional features may prove challenging to execute.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* A new account can be created
* Login for account access
* Daily art prompt
* Artwork can be uploaded to the general feed
* Comments can be left on artwork
* Customizable app settings

**Optional Nice-to-have Stories**

* Customizable user profile page
* Friend list
* Chat with other users
* Search for artwork
* Favorite artwork to find it quickly
* Featured artwork page
* Monetization

### 2. Screen Archetypes

* Login Screen: -Log into account
* Register Screen: -Create new account
* Artwork Feed Screen: -Shows currently posted artwork
                    * -Comments can be left on posted artwork
* Daily Prompt Screen: - User can view daily art prompt
* Upload Artwork Screen: -User can upload art work to post it to the artwork feed
* Settings Screen: -Customize app settings:
                    +dark/light theme
                    +notification settings
* Profile Screen: -User can change profile picture

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Artwork feed
* Daily prompt
* Profile account page

Optional:

* Profile
* Featured artwork
* Friend list
* Commission postings feed
* Chat/Friends List

**Flow Navigation** (Screen to Screen)

* Flow Navigation (Screen to Screen)
* Login Screen: -Goes to artwork feed
* Register Screen: -Goes to artwork feed
* Artwork Feed Screen: -View posted artwork from users (Detail Screen)
* Daily Prompt Screen: -View daily art prompt (Detail Screen)
* Upload Artwork Screen: -Goes to artwork feed
* Settings Screen: -View settings page(Detail Screen)
* Profile Screen: -View profile page(Detail Screen)

## Wireframes
<img src="https://github.com/compiling-errors/ArtsyFartsy/blob/master/Wireframe.png" width=600>

### Digital Wireframes & Mockups
https://www.figma.com/file/W3SFBGtTPcDWg3Xs7BFgBPKl/ArtsyFartsy?node-id=0%3A1 


### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

Model: Artwork Post

| Property          | Type               | Description                                     |
|:---               |:---                |:---                                             |
|artworkPostId      |String              |user post’s unique id                            |
|author             |Pointer to User     |Author of post (image/comment)                   |
|artworkImage	      |File	               |User uploaded artwork image                      |
|artworkDescription	|String	             |User written description of personal artwork post|
|numComments	      |Number	             |Any/all comments posted on user’s artwork post   |
|artworkCaption	    |String	             |User written caption for artwork                 |
|profileImage	      |File	               |User uploaded profile image                      |
|artworkFeed	      |Array	             |User uploaded artwork posts                      |


Model: Account

| Property          | Type               | Description                                     |
|:---               |:---                |:---                                             |
|username           | String             |  User’s username                                |
|password	          |String	             |User’s password                                  |
|email	            |String	             |User’s email address                             |


Model: Daily Prompt Page

|Property	          |Type	               |Description                                      |
|:---               |:---                |:---                                             |
|followedProfile    |Pointer to User	   |A profile/account that a user is following       |                                 
|promptAdjective	  |JSON Object	       |An adjective pulled from a source drawing prompt |                                 
|promptNoun	        |JSON Object	       |A noun pulled from a source for a drawing prompt |                            
|promptVerb	        |JSON Object	       |A verb pulled from a source for a drawing prompt |                                  


Model: Request Post

|Property	          |Type	               |Description                                      |
|:---               |:---                |:---                                             |
|requestPostId	    |String	             |user post’s unique id                            |
|author	            |Pointer to User	   |Author of post (image/comment)                   |
|requestDescription	|String	             |User written description of request post         |                                
|requestNumComments	|Number	             |Any/all comments posted on user’s artwork post   |
|requestCaption	    |String	             |User written caption for request                 |
|profileImage	      |File	               |User uploaded profile image                      |
|requestFeed	      |Array	             |User uploaded request posts                      |



Model: Individual User's Followed Feed

|Property	          |Type	               |Description                                      |
|:---               |:---                |:---                                             |
|username	          |Pointer to User	   |Author of post (image/comment)                   |
|profileImage	      |File	               |User uploaded profile image                      |
|lastArtworkImage   |File                |Followed user's last artwork post                |
|followedFeed	      |Array	             |User's list of followed users                    |
|followedDate	      |DateTime            |When user has followed another user              |
|followedList       |Array               |User's followed list                             |

### Networking
...........

Parse Networking Methods
|Parse Method                   |Example
|:---                           |:---                
|Make object/Save object        |Post artwork/Save artwork
|Object queries(artwork feed)   |Get artwork images for artwork feed
|Object queries(request)        |Get request text for request feed
|Delete objects                 |Delete artwork images/request text

..........


**Login page** - **Sign up page**
- (READ/GET) User profile upon signing in
- (CREATE/POST) Creating a new user account
```swift
class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func OnSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = userNameField.text!
        user.password = passwordField.text!
        user.signUpInBackground {
            (succeeded: Bool, error) in
            if succeeded {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
            print("Error: \(String(describing: error?.localizedDescription)))")
            }}}
    @IBAction func OnLogIn(_ sender: Any) {
        let username = userNameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user, error) in
            if user != nil {
                        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
            print("Error: \(String(describing: error?.localizedDescription)))")
}}}}
```

**Drawing Prompt**
- NA
 
**User Homepage**
- (READ/GET) User’s Artwork Feed and settings

```swift
    let query = PFQuery(className: "artworkImage")
    query.whereKey("author", equalTo: author)
    query.order(byDescending: "artworkDate")
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let posts = posts {
          print("Successfully retrieved \(posts.count) posts.")
      // TODO: Do something with posts...
       }
    }
```
- (UPDATE/PUT) Follow button - updates followed list

**Drawing Submission Page** - **Profile Photo**
- (CREATE/POST) Post the users completed artwork
- (UPDATE/PUT) Change a user’s profile image
```swift
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
}
@IBAction func OnSubmitButton(_ sender: Any) {
    let post = PFObject(className: "Posts")
    post["caption"] = commentTextField.text!
    post["author"] = PFUser.current()!   
    let imageData = myImageView.image!.pngData()
    let file = PFFileObject(data: imageData!)!  
    post["image"] = file    
    post.saveInBackground { (success, error) in
if success {
    self.dismiss(animated: true, completion: nil)
    print("saved!")
}else {
    print("error!")
}}}
@IBAction func OnCameraButton(_ sender: Any) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true  
if UIImagePickerController.isSourceTypeAvailable(.camera){
    picker.sourceType = .camera
} else {
    picker.sourceType = .photoLibrary
} 
    present(picker, animated: true, completion: nil)  
}
    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] as! UIImage  
    let size = CGSize(width: 300, height: 300)
    let scaledImage = image.af_imageScaled(to: size)    
    myImageView.image = scaledImage    
    dismiss(animated: true, completion: nil)
}}
```
**Settings**
- (Update/PUT) Change the user’s username, password, email
 

**Following Page**
- (READ/GET) Shows the user’s followed accounts artwork as a feed
```swift
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

@IBOutlet weak var myTableView: UITableView!

    var posts = [PFObject]()
override func viewDidLoad() {
    super.viewDidLoad()
    myTableView.delegate = self
    myTableView.dataSource = self    
} 
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) 
    let query = PFQuery(className: "Posts")
    query.includeKey("author")
    query.limit = 20  
    query.findObjectsInBackground { (posts, error) in
    if posts != nil {
        self.posts = posts!
        self.myTableView.reloadData()
}}}
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = myTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell     
    let post = posts[indexPath.row]   
    let user = post["author"] as! PFUser
    cell.userNameLabel.text = user.username
    cell.commentLabel.text = post["caption"] as? String   
    let imageFile = post["image"] as! PFFileObject
    let urlString = imageFile.url!
    let url = URL(string: urlString)!   
    cell.photoView.af_setImage(withURL: url)
        
    return cell
}}
```
**Artwork Feed**
- (READ/GET) feed of all user’s submissions
```swift
    let query = PFQuery(className: "artworkImage")
    query.order(byDescending: "artworkDate")
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let posts = posts {
          print("Successfully retrieved \(posts.count) posts.")
      // TODO: Do something with posts...
       }
    }
```
**Specific Artwork Piece page**
- (READ/GET) Gets a specific piece of artwork selected by user (photo, title, caption, username)
```swift
    let query = PFQuery(className: "artImage")
    query.whereKey("username" , equalTo: username)
    query.whereKey("img" , equalTo: img)
    query.findObjectsInBackground { (img: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let  img = img {
          print("Successfully posted image.")
      // TODO: Do something with users...
       }
    }
 ``` 
**Optionals**
-
**Commission feed**
- (Read/Get)- Gets commission Post and puts it on the table feed
```swift
    let query = PFQuery(className: "commissionPost")
    query.whereKey("username", equalTo: username)
    query.whereKey("postNumber", equalTo: postNumber)
    query.order(byDescending: "uploadDate")
    query.findObjectsInBackground { (commissionPosts: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let  commissionPosts = commissionPosts {
          print("Successfully posted.")
      // TODO: Do something with users...
       }
    }
```   
**Commission Post**
- (Create/Post)- Add Request to the commission feed. 
- Read/Get- for All Users Request Feed
```swift
    let query = PFQuery(className: "requestDescription")
    query.order(byDescending: "requestDate")
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let posts = posts {
          print("Successfully retrieved \(posts.count) posts.")
      // TODO: Do something with posts...
       }
    }
```
**Commission Accept**
- (Update/Put)- Send a message accepting a commission or asking about the request.

**Messages/ Inbox**
- (Read/Get)- Get the message from another user
- (Update/Put)- Update the message box.
---

