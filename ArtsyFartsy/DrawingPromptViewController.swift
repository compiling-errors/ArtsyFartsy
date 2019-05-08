//
//  DrawingPromptViewController.swift
//  ArtsyFartsy
//
//  Created by REBEKKA GEEB on 5/6/19.
//  Copyright © 2019 MICHAEL BENTON, REBEKKA GEEB. All rights reserved.
//

import UIKit
import Parse

class DrawingPromptViewController: UIViewController {
    
    
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
