//
//  UploadArtworkViewController.swift
//  ArtsyFartsy
//
//  Created by Tiny on 4/10/19.
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
