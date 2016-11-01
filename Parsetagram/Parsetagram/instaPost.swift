//
//  instaPost.swift
//  Parsetagram
//
//  Created by JonLuca De Caro on 10/31/16.
//  Copyright © 2016 JonLuca De Caro. All rights reserved.
//

import Parse
import UIKit

class instaPost: NSObject {
    
    class func sendPic(_ image: UIImage?, withCaption caption: String?) -> Bool {
        var successOverall = true
        let post = PFObject(className: "instaPost")
        
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackground{(success, error) -> Void in
            if(error == nil)
            {
                print("Success")
                
            }
            else
            {
                print("Error")
                successOverall = false
            }
        }
        
        return successOverall
        
    }
    
    class func getPFFileFromImage(_ image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
