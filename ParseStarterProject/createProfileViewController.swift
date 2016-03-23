//
//  createProfileViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class createProfileViewController: UIViewController {
    @IBAction func next(sender: AnyObject) {
       
        if firstNameBox.text != "" && lastNameBox.text != "" {
            
            var user = PFUser()
            user.username = emailAccepted.lowercaseString
            user.password = passwordAccepted
            user["mobile"] = mobileAccepted
            user["firstName"] = firstNameBox.text
            user["lastName"] = lastNameBox.text
            user["delivering"] = false
            user["currentOrder"] = ""
            
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    print(error)
                } else {
                    currentUser = self.firstNameBox.text! + " " + self.lastNameBox.text!
                    //update memory
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(NSArray(array:[emailAccepted, passwordAccepted]), forKey: "defaultUserData")
                    
                    
                    
                    self.performSegueWithIdentifier("userDidCreateAccount", sender: nil)
                    print("success")
                    
                    
                }
            }
            
            
        }
        
        
        
    }
    @IBOutlet weak var firstNameBox: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
