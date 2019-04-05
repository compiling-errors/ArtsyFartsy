//
//  ArtworkUploadViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/4/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ArtworkUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets need to be placed here, UIImageview and UItextfield for caption

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Connect submit button to submit artwork photo for upload
    
    //code inside submit button
        //New artwork post object
    // let artworkPost = PFObject(classname: "artworkPosts")
    
//    //Create dictionary
//    //If you add stuff later, things will be nil: must handle this or delete table and start over again
//    artworkPost["caption"] = commentTextField.text!
//    //Current logged in "owner"
//    artworkPost["author"] = PFUser.current()!
//
//    //Saved in a separate table for my photos
//    let artworkImageData = photoImageView.image!.pngData()
//    let file = PFFileObject(data: artworkImageData!)
//
//    //This column has url
//    artworkPost["artwork"] = file
//
//    post.saveInBackground { (success, error) in
//    if success{
//    self.dismiss(animated: true, completion: nil)
//    print("Saved!")
//    } else{
//    print("Error!")
//    }
//    }
    
    //Connect camera button that allows for custom camera, here
        //Make sure "User Interaction Enabled" is checked on storyboard, 4th icon from the left (not just under "traits" on other page)
        //See parstagram cameraviewcontroller file
    
    //todo change size and make sure there is aspect fill
    //Allows user to pick artwork image after editing
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let artworkImage = info[.editedImage] as! UIImage
        
        //Have to resize image after retrieving
        let artworkImageSize = CGSize(width: 300, height: 300)
        
        let artworkScaledImage = image.af_imageAspectScaled(toFill: size)
        
        //todo: need to fix imageview, match name
        //Place scaled image in image view
        //photoImageView.image = scaledImage
        
        //Dismiss camera view
        dismiss(animated: true, completion: nil)
    }

}
