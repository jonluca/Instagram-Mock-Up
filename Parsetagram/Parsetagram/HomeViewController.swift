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

    @IBOutlet weak var tableView: UITableView!
    var posts:[PFObject] = []

    let HeaderViewIdentifier = "topView"
    var isMore = false


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlGetPosts(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the position of one screen length before the bottom of the results
        let scrollViewContentHeight = tableView.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
            isMore = true
            
            // ... Code to load more results ...
            getPictures()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count;
    }
    func refreshControlGetPosts(_ refreshControl: UIRefreshControl)
    {
        getPictures()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        let textPfObject = self.posts[indexPath.section]
        if let stringText = textPfObject.value(forKey: "caption") {
            
            cell.caption.text = stringText as? String
            cell.instaImage.file = textPfObject["media"] as? PFFile
            cell.instaImage.loadInBackground()
            
        }
        return cell
    }
    
    func getPictures()
    {
        let query = PFQuery(className: "instaPost")
        query.findObjectsInBackground { (returned, error) -> Void in
            if let returned = returned {
                self.posts = returned
                self.tableView.reloadData()
                // do something with the array of object returned by the call
            } else {
                print(error?.localizedDescription ?? "asdf")
            }
        }
    }


}
