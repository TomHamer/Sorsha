//
//  registerViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 22/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var emailAccepted = ""
var passwordAccepted = ""
var mobileAccepted = ""
var firstName = ""
var lastName = ""


class registerViewController: UIViewController {
    
    @IBAction func next(sender: AnyObject) {
        registerUser()
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
    
        }))
    self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func registerUser() {
        
        //using email as username
        
        if email.text != "" {
            if NSString(string: email.text!).containsString("@") && NSString(string: email.text!).containsString(".") {
                if mobile.text != "" {
                    if password.text != "" {
                    var query = PFUser.query()
                    query!.whereKey("username", equalTo:email.text!)
                    var usernameP = query!.getFirstObject()
                    print(usernameP)
                        if usernameP != nil {
                            var alert = UIAlertController(title: "Please Sign In", message: "This email has already been registered", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                                alert.dismissViewControllerAnimated(true, completion: nil)
                                
                            }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else {
                            emailAccepted = email.text!
                            passwordAccepted = password.text!
                            mobileAccepted = mobile.text!
                            self.performSegueWithIdentifier("loginDetailsOK", sender: nil)
                            
                        }
        
                        } else {
                        alertUser("Error", message: "Please enter a password")
                    }
            } else {
                alertUser("Error", message: "Please enter your mobile number")
                }
            } else {
              alertUser("Error", message: "Please enter a valid email")
                }
        } else {
            alertUser("Error", message: "Please enter an email")
        
        }
    }

    
    
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
