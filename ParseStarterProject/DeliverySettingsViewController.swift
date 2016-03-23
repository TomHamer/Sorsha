//
//  DeliverySettingsViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 10/02/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class DeliverySettingsViewController: UIViewController {
    @IBOutlet weak var serviceSwitch: UISwitch!
    @IBAction func serviceValueChanged(sender: AnyObject) {
        if serviceSwitch.on == true {
            
            PFUser.currentUser()!["serviceOn"] = true
            
        } else {
            PFUser.currentUser()!["serviceOn"] = false
            //service switch has been turned off
        }
    }
    @IBAction func signOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil {
                print("user has been logged out")
                self.performSegueWithIdentifier("signOutDelivery", sender: nil)
            } else {
                
                self.alertUser("Woops", message: "something went wrong")
            }
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()!["serviceOn"] as? Bool == true {
            serviceSwitch.on = true
        } else {
            serviceSwitch.on = false
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
            UIControl().sendAction(Selector("suspend"), to: UIApplication.sharedApplication(), forEvent: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}
