//
//  orderCoffeeViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 27/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class orderCoffeeViewController: UIViewController {
    func getTime() -> String {
        
        let date = NSDate()
        let strDate = NSString(string: String(date))
        let time = strDate.substringWithRange(NSRange(location: 11, length: 8))
        return time
    }
    
    @IBAction func cancelled(sender: AnyObject) {
        coffeeOrdered = false
        currentRequest = [String:String]()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(currentRequest, forKey: "orderDetails")
    }
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    

    @IBAction func confirm(sender: AnyObject) {
        
        
        if typeSelected == true && sizeSelected == true {
            
        
        
        
       
        var order = PFObject(className:"orders")
        order["x"] = currentRequest["x"]
        order["y"] = currentRequest["y"]
        order["level"] = currentRequest["level"]
        order["size"] = currentRequest["size"]
        order["type"] = currentRequest["type"]
        order["time"] = getTime()
        order["progress"] = "orderRecieved"
        order["name"] = currentUser
        order["deliverer"] = "undefined"
        order["user"] = PFUser.currentUser()!.username
        
    
        
        order.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                currentRequest["objectId"] = order.objectId
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(currentOrderNumber, forKey: "currentOrderNumber")
                //update memory
                print(order.objectId)
                if let currentOrder = order.objectId {
                PFUser.currentUser()!["currentOrder"] = currentOrder
                PFUser.currentUser()!.saveInBackground()
                }
                defaults.setObject(currentRequest, forKey: "orderDetails")
                //display alert
                var alert = UIAlertController(title: "Success", message: "You have ordered your coffee", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    self.performSegueWithIdentifier("coffeeOrderSuccess", sender: nil)
                    alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                    })
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                if let error = error {
                self.alertUser("Oops, something went wrong!", message: String(error))
                } else {
                    self.alertUser("Oops, something went wrong!", message: "Please try again later")
                }
                // There was a problem, check error.description
            }
            }
        }
        
    }
    var sizeSelected = false
    var typeSelected = false
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var smallButton: UIButton!
    
    @IBOutlet weak var lateButton: UIButton!
    @IBOutlet weak var expButton: UIButton!
    @IBOutlet weak var cappuButton: UIButton!
    @IBAction func selectLate(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        expButton.titleLabel!.textColor = UIColor.whiteColor()
        cappuButton.titleLabel!.textColor = UIColor.whiteColor()
        typeSelected = true
        currentRequest["type"] = "late"
    }
    @IBAction func selectExp(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        typeSelected = true
        currentRequest["type"] = "expresso"
        lateButton.titleLabel!.textColor = UIColor.whiteColor()
        cappuButton.titleLabel!.textColor = UIColor.whiteColor()
        
    }
    @IBAction func selectCappu(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        typeSelected = true
        currentRequest["type"] = "cappucino"
        expButton.titleLabel!.textColor = UIColor.whiteColor()
        lateButton.titleLabel!.textColor = UIColor.whiteColor()
    }
    @IBAction func large(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        mediumButton.titleLabel!.textColor = UIColor.whiteColor()
        smallButton.titleLabel!.textColor = UIColor.whiteColor()
        currentRequest["size"] = "large"
        sizeSelected = true
    }
    @IBAction func medium(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        largeButton.titleLabel!.textColor = UIColor.whiteColor()
        smallButton.titleLabel!.textColor = UIColor.whiteColor()
        currentRequest["size"] = "medium"
        sizeSelected = true
    }
    @IBAction func small(sender: AnyObject) {
        sender.titleLabel!!.textColor  = UIColor.blueColor()
        mediumButton.titleLabel!.textColor = UIColor.whiteColor()
        largeButton.titleLabel!.textColor = UIColor.whiteColor()
        currentRequest["size"] = "small"
        sizeSelected = true
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
