//
//  LoginPageViewController.swift
//  ArtsyFartsy
//
//  Created by Tiny on 4/9/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit
import Parse

class LoginPageViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        {(user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "TabBarSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                
                //Show an error message to user at failed login attempt
                let alertView = UIAlertView(
                   title: "Error",
                   message: "Invalid username and/or password. Please try again.",
                   delegate: nil,
                   cancelButtonTitle: "OK"
                 )
                 alertView.show()
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        // add email: user.email = emailField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "TabBarSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
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
