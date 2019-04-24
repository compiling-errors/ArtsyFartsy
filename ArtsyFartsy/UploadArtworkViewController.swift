//
//  UploadArtworkViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 4/10/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class UploadArtworkViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var artworkImgView: UIImageView!
    @IBOutlet weak var artworkName: UITextField!
    @IBOutlet weak var artworkMoreInfo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButton(_ sender: Any) {
        
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
            artworkPost["likeCount"] = 0
            
            //Saved in a separate table for my photos
            let imageData = self.artworkImgView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            
            //This column has url
            artworkPost["image"] = file
            
            artworkPost.saveInBackground { (success, error) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                    print("Saved artwork post!")
                    
                    //Show a success message to user
                    let alertView = UIAlertView(
                        title: "Post Complete",
                        message: "Success! Artwork posted to public feed.",
                        delegate: nil,
                        cancelButtonTitle: "OK"
                    )
                    alertView.show()
                    
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
        let size = CGSize(width: 300, height: 300)
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
