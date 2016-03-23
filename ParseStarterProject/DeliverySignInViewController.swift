//
//  DeliverySignInViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 8/02/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class DeliverySignInViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!

    @IBAction func done(sender: AnyObject) {
        
        if password.text != "" && email.text != "" {
            
            var query = PFUser.query()
            query!.whereKey("username", equalTo: email.text!)
            query!.whereKey("delivering", equalTo:true)
            query!.getFirstObjectInBackgroundWithBlock({ (userDetails, error) -> Void in
                if error == nil {
                  print("it worked")
                  var delivering = userDetails!["delivering"] as? Bool
                    print(delivering)
                    if delivering == true {
                        
                        PFUser.logInWithUsernameInBackground(self.email.text!, password: self.password.text!) {
                            (user: PFUser?, error: NSError?) -> Void in
                            if user != nil {
                                 self.performSegueWithIdentifier("deliveryLoginSuccessful", sender: nil)
                                print("logon worked")
                                currentUser = String(user!["firstName"]!) + " " + String(user!["lastName"]!)
                               
                                
                            } else {
                                if error != nil {
                                    self.alertUser("Error", message: (error?.description)!)
                                } else {
                                    self.alertUser("Error", message: "something went wrong")
                                }
                            }
                            
                            
                            
                            
                        }
                        
                            
                        } else {
                         self.alertUser("sorry", message: "it looks like your not signed up for delivery")
                        }
                    
                    } else {
                    print(error!.description)
                }

                
            })
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
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
