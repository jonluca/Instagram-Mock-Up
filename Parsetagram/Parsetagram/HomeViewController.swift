//
//  HomeViewController.swift
//  Parsetagram
//
//  Created by JonLuca De Caro on 10/31/16.
//  Copyright © 2016 JonLuca De Caro. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! PostTableViewCell
//        if let temp = self.messages[indexPath.row] as? PFObject{
//            cell.messageBody.text = (self.messages[indexPath.row] as! PFObject).object(forKey: "text") as! String?
//            if let tempUser = (self.messages[indexPath.row] as! PFObject).object(forKey: "userProf") as? String? {
//                //print(tempUser.username)
//                cell.userLable.text = tempUser
//            }
//        }
        
        return cell          }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
