//
//  UploadArtworkViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/10/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class UploadArtworkViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var artworkName: UITextField!
    @IBOutlet weak var artworkMoreInfo: UITextField!
    // Choose Photo Button
    // todo: Link up to new button
    //@IBOutlet weak var chooseImageBtn: UIButton!
    
    //@IBOutlet weak var imgProfile: UIImageView!
    //@IBOutlet weak var btnChooseImage: UIButton!
    
    //var imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var nounLabel: UILabel!
    @IBOutlet weak var verbLabel: UILabel!
    @IBOutlet weak var adjectiveLabel: UILabel!
    
    var word: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Follow user
        let query = PFQuery(className:"SelectedWords")
        query.whereKeyExists("objectId")
        query.includeKey("name")
        query.includeKey("verb")
        query.includeKey("adjective")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print("Error, unable to fetch drawing prompt:", error.localizedDescription)
            } else {
                let something = objects![0]
                
                self.nounLabel.text = something["noun"] as? String
                self.verbLabel.text = something["verb"] as? String
                self.adjectiveLabel.text = something["adjective"] as? String
            }
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadArtworkViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss(){
        view.endEditing(true)
    }

    @IBAction func postButton(_ sender: Any) {
        let nameCheck = artworkName.text
        let moreinfoCheck = artworkMoreInfo.text
        
        if (nameCheck?.isEmpty)! || (moreinfoCheck?.isEmpty)! || self.artworkImgView.image == nil {
            let alertView = UIAlertView(
                title: "Error!",
                message: "Error! 'Name', 'MoreInfo', and picture selected cannot be left blank. Please try again.",
                delegate: nil,
                cancelButtonTitle: "OK"
            )
            alertView.show()

        } else {
            //Ask user to confirm that they want to post artwork to public feed
            let alertController = UIAlertController(title: "Post artwork?", message: "Post your artwork to the public feed?", preferredStyle: .alert)
            //If user clicks post button, post to feed
            let postAction = UIAlertAction(title: "Post", style: .default) { (action) in
                //Create new object
                let artworkPost = PFObject(className: "ArtworkPosts")
                
                //Create dictionary
                //If you add stuff later, things will be nil: must handle this or delete table and start over again
                artworkPost["name"] = self.artworkName.text!
                artworkPost["moreinfo"] = self.artworkMoreInfo.text!
                artworkPost["author"] = PFUser.current()!
                artworkPost["authorUsername"] = PFUser.current()!.username!
                artworkPost["authorId"] = PFUser.current()!.objectId!
                artworkPost["likeCount"] = 0
                artworkPost["nounOfDay"] = self.nounLabel.text!
                artworkPost["verbOfDay"] = self.nounLabel.text!
                artworkPost["adjectiveOfDay"] = self.nounLabel.text!
                
                //Saved in a separate table for my photos
                let imageData = self.artworkImgView.image!.pngData()
                let file = PFFileObject(data: imageData!)
                
                //This column has url
                artworkPost["image"] = file
                
                artworkPost.saveInBackground { (success, error) in
                    if success{
                        print("Saved artwork post!")
                        
                        //Show a success message to user
                        let alertView = UIAlertView(
                            title: "Post Complete",
                            message: "Success! Artwork posted to public feed.",
                            delegate: nil,
                            cancelButtonTitle: "OK"
                        )
                        alertView.show()
                        
                        self.artworkName.text = ""
                        self.artworkMoreInfo.text = ""
                        self.artworkImgView.image = nil
                        
                    } else {
                        print("Error! Unable to save artwork post.")
                        
                        //Show an error message to user
                        let alertView = UIAlertView(
                            title: "Error",
                            message: "Unable to post artwork. Please try again.",
                            delegate: nil,
                            cancelButtonTitle: "OK"
                        )
                        alertView.show()
                    }
                }
                
            }
            //If user clicks cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                //do nothing
            }
            alertController.addAction(postAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true)
            
        }
    }
    
    @IBAction func uploadArtworkTapButton(_ sender: Any) {
        let artworkPicker = UIImagePickerController()
        artworkPicker.delegate = self
        artworkPicker.allowsEditing = true
        
        //Uses camera on regular phone, or photolibrary for simulator, prevent crash
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            artworkPicker.sourceType = .camera
        } else {
            artworkPicker.sourceType = .photoLibrary
        }
        
        present(artworkPicker, animated: true, completion: nil)
        
    }
    
    //Have user be able to pick photo from camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        //Resize photo
        let size = CGSize(width: 396, height: 296)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        artworkImgView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
    
    
    
    
    
    
    
    
    
    
    /// new code
    
    /*
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            self.artworkImgView.layer.cornerRadius = artworkImgView.bounds.width/2
            self.artworkImgView.layer.borderWidth = 1
            self.artworkImgView.layer.borderColor = UIColor.lightGray.cgColor
            
            self.btnChooseImage.layer.cornerRadius = 5
        }
        
        @IBAction func btnChooseImageOnClick(_ sender: UIButton) {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            
            self.present(alert, animated: true, completion: nil)
        }
        
        //MARK: - Open the camera
        func openCamera(){
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                //If you dont want to edit the photo then you can set allowsEditing to false
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //MARK: - Choose image from camera roll
        
        func openGallary(){
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    extension ProfileController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            /*
             Get the image from the info dictionary.
             If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
             instead of `UIImagePickerControllerEditedImage`
             */
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
                self.artworkImgView.image = editedImage
            }
            
            //Dismiss the UIImagePicker after selection
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.isNavigationBarHidden = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    */
    


/* example picker code
 @IBAction func buttonOnClick(_ sender: UIButton)
 {
 self.btnEdit.setTitleColor(UIColor.white, for: .normal)
 self.btnEdit.isUserInteractionEnabled = true
 
 let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
 alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
 self.openCamera()
 }))
 
 alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
 self.openGallary()
 }))
 
 alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
 
 /*If you want work actionsheet on ipad
 then you have to use popoverPresentationController to present the actionsheet,
 otherwise app will crash on iPad */
 switch UIDevice.current.userInterfaceIdiom {
 case .pad:
 alert.popoverPresentationController?.sourceView = sender
 alert.popoverPresentationController?.sourceRect = sender.bounds
 alert.popoverPresentationController?.permittedArrowDirections = .up
 default:
 break
 }
 
 self.present(alert, animated: true, completion: nil)
 }
 
 func openCamera()
 {
 if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
 {
 imagePicker.sourceType = UIImagePickerControllerSourceType.camera
 imagePicker.allowsEditing = true
 self.present(imagePicker, animated: true, completion: nil)
 }
 else
 {
 let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 }
 
 func openGallary()
 {
 imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
 imagePicker.allowsEditing = true
 self.present(imagePicker, animated: true, completion: nil)
 }
 
 
 
 full example
 Import UIKit
 
 class ProfileController: UIViewController{
 
 @IBOutlet weak var imgProfile: UIImageView!
 @IBOutlet weak var btnChooseImage: UIButton!
 
 var imagePicker = UIImagePickerController()
 
 override func viewDidLoad() {
     super.viewDidLoad()
         // Do any additional setup after loading the view, typically from a nib.
     }
 
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         self.imgProfile.layer.cornerRadius = imgProfile.bounds.width/2
         self.imgProfile.layer.borderWidth = 1
         self.imgProfile.layer.borderColor = UIColor.lightGray.cgColor
 
         self.btnChooseImage.layer.cornerRadius = 5
     }
 
     @IBAction func btnChooseImageOnClick(_ sender: UIButton) {
 
     let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
         self.openCamera()
     }))
 
     alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
        self.openGallary()
     }))
 
     alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
 
         //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
         switch UIDevice.current.userInterfaceIdiom {
         case .pad:
         alert.popoverPresentationController?.sourceView = sender
         alert.popoverPresentationController?.sourceRect = sender.bounds
         alert.popoverPresentationController?.permittedArrowDirections = .up
         default:
         break
     }
 
 self.present(alert, animated: true, completion: nil)
 }
 
 //MARK: - Open the camera
 func openCamera(){
 if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
 imagePicker.sourceType = UIImagePickerControllerSourceType.camera
 //If you dont want to edit the photo then you can set allowsEditing to false
 imagePicker.allowsEditing = true
 imagePicker.delegate = self
 self.present(imagePicker, animated: true, completion: nil)
 }
 else{
 let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 }
 
 //MARK: - Choose image from camera roll
 
 func openGallary(){
 imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
 //If you dont want to edit the photo then you can set allowsEditing to false
 imagePicker.allowsEditing = true
 imagePicker.delegate = self
 self.present(imagePicker, animated: true, completion: nil)
 }
 }
 
 //MARK: - UIImagePickerControllerDelegate
 extension ProfileController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 /*
 Get the image from the info dictionary.
 If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
 instead of `UIImagePickerControllerEditedImage`
 */
 if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
 self.imgProfile.image = editedImage
 }
 
 //Dismiss the UIImagePicker after selection
 picker.dismiss(animated: true, completion: nil)
 }
 
 func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
 picker.isNavigationBarHidden = false
 self.dismiss(animated: true, completion: nil)
 }
 }
 */
