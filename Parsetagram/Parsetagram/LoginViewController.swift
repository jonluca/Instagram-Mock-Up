//
//  LoginViewController.swift
//  Parsetagram
//
//  Created by JonLuca De Caro on 10/24/16.
//  Copyright © 2016 JonLuca De Caro. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        let username = email.text ?? ""
        let pass = password.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: pass) { (user, error) -> Void in
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
                let vc : InstaViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcMainLogin") as! InstaViewController
                self.present(vc, animated: true, completion: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }

    @IBAction func signUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = email.text
        user.password = password.text
        user.email = email.text
        
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
                let vc : InstaViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcMainLogin") as! InstaViewController
                self.present(vc, animated: true, completion: nil)
                // Hooray! Let them use the app now.
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
