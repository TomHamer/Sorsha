//
//  signInViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 22/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class signInViewController: UIViewController {
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func pauseApp() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
        
        //To use this function, these two lines need to go below it
        //activityIndicator.center = self.view.center
        //view.addSubview(activityIndicator)
    }
    func restartApp() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    func signInUser() {
    if password.text != "" && email.text != "" {
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        pauseApp()
        activityIndicator.bringSubviewToFront(view)
    PFUser.logInWithUsernameInBackground(self.email.text!, password: self.password.text!) {
    (user: PFUser?, error: NSError?) -> Void in
    if user != nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSArray(array:[self.email.text!, self.password.text!]), forKey: "defaultUserData")
        if let currentOrderNumber = user!["currentOrder"] as? String {
            if currentOrderNumber != "" {
            defaults.setObject(currentOrderNumber, forKey: "currentOrderNumber")
            defaults.setObject(true, forKey: "coffeeOrdered")
            var query = PFQuery(className:"orders")
            query.getObjectInBackgroundWithId(currentOrderNumber, block: { (currentOrderData, error) -> Void in
                if currentOrderData != nil {
                    
                    currentRequest = ["x":String(currentOrderData!["x"]!), "y":String(currentOrderData!["y"]!), "level":String(currentOrderData!["level"]!), "type":String(currentOrderData!["type"]!), "size":String(currentOrderData!["size"]!), "objectId":String(currentOrderData!.objectId)]
                    defaults.setObject(currentOrderData!["level"]!, forKey: "level")
                    defaults.setObject(currentRequest, forKey: "orderDetails")
                }
                
            })
            
            }
            
            
            
        }
        currentUser = String(user!["firstName"]!) + " " + String(user!["lastName"]!)
    self.restartApp()
    self.performSegueWithIdentifier("signInSuccess", sender: nil)
        //update memory
        
    } else {
    self.restartApp()
    print(error)
        
            self.alertUser("Error", message: (error?.description)!)
        
    }
    }
    }
    
    }

    @IBAction func done(sender: AnyObject) {
        signInUser()
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
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
