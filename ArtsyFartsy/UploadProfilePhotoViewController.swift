////
////  UploadProfilePhotoViewController.swift
////  ArtsyFartsy
////
////  Created by REBEKKA GEEB on 4/11/19.
////  Copyright © 2019 MICHAEL BENTON. All rights reserved.
////
//
//import UIKit
//import AlamofireImage
//import Parse
//
//class UploadProfilePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    //connect outlets
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    //connect button for selecting profile pic
////    {
////    let artworkPicker = UIImagePickerController()
////    artworkPicker.delegate = self
////    artworkPicker.allowsEditing = true
////
////    //Uses camera on regular phone, or photolibrary for simulator, prevent crash
////    if UIImagePickerController.isSourceTypeAvailable(.camera){
////    artworkPicker.sourceType = .camera
////    } else {
////    artworkPicker.sourceType = .photoLibrary
////    }
////
////    present(artworkPicker, animated: true, completion: nil)
////    }
//
//    //Have user be able to pick photo from camera
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        let image = info[.editedImage] as! UIImage
//
//
//        //Resize photo
//        let size = CGSize(width: 300, height: 300)  //Change pic size?
//        let scaledImage = image.af_imageAspectScaled(toFill: size)
//
//        artworkImgView.image = scaledImage
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    //todo save and display profile pic
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
