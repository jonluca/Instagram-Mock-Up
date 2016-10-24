//
//  ChatViewController.swift
//  ParseClient
//
//  Created by JonLuca De Caro on 10/1/16.
//  Copyright © 2016 JonLuca De Caro. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    var messages: NSArray = []
    @IBAction func send(_ sender: AnyObject) {
        let message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = messageText.text
        message["userProf"] = PFUser.current()?.username
        print(PFUser.current()?.username);
        message.saveInBackground {
            (success, error) -> Void in
            if (success) {
                self.messageText.text = ""
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(query), userInfo: nil, repeats: true)
        query()
        // Do any additional setup after loading the view.
    }
    
    func query(){
        let query = PFQuery(className:"Message_fbuJuly2016")
        //        query.findObjectsInBackground {
        //            (messages, error) -> Void in
        //
        //            if error == nil {
        //                // The find succeeded.
        //                print("Successfully retrieved \(messages!.count) scores.")
        //                // Do something with the found objects
        //                if let messages = messages {
        //                    for messages in messages {
        //                        print(messages.)
        //                    }
        //                }
        //            } else {
        //                // Log details of the failure
        //                print(error?.localizedDescription)
        //            }
        //        }
        query.findObjectsInBackground {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                //                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects as NSArray
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                //                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell
        if let temp = self.messages[indexPath.row] as? PFObject{
            cell.messageBody.text = (self.messages[indexPath.row] as! PFObject).object(forKey: "text") as! String?
            if let tempUser = (self.messages[indexPath.row] as! PFObject).object(forKey: "userProf") as? String? {
                //print(tempUser.username)
                cell.userLable.text = tempUser
            }
        }
        
        return cell
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
