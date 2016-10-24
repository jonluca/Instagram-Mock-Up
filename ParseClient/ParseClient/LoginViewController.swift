//
//  ViewController.swift
//  ParseClient
//
//  Created by JonLuca De Caro on 10/1/16.
//  Copyright © 2016 JonLuca De Caro. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func signUp(_ sender: AnyObject) {
        let user = PFUser()
        user.username = emailTF.text
        user.password = passwordTF.text
        user.email = emailTF.text
        
        user.signUpInBackground {
            (succeeded, error) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                let alertController = UIAlertController(title: "Error!", message: errorString, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true){
                    
                }
                // Show the errorString somewhere and let the user try again.
            } else {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc : ChatViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcMainLogin") as! ChatViewController
                self.present(vc, animated: true, completion: nil)
                // Hooray! Let them use the app now.
            }
        }
    }
    @IBAction func Login(_ sender: AnyObject) {
        
        let username = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                let alertController = UIAlertController(title: "Error!", message: errorString, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true){
                    
                }
            } else {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc : ChatViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcMainLogin") as! ChatViewController
                self.present(vc, animated: true, completion: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

