//
//  customerSettings.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 3/02/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class customerSettings: UIViewController {

    
    @IBAction func signOut(sender: AnyObject) {
        
        PFUser.logOut()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("coffeeOrdered")
        defaults.removeObjectForKey("currentOrderNumber")
        defaults.removeObjectForKey("orderDetails")
        defaults.removeObjectForKey("level")
        menuOut = false
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
