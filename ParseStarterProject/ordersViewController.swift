//
//  ordersViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 29/01/2016.
//  Copyright © 2016 Thomas Hamer. All rights reserved.
//

var orderArray = []
import UIKit
import Parse


class ordersViewController: UITableViewController {
   
    
    var rowCount = 0
    
    var orderArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = PFUser.currentUser()!.username
        let predicate = NSPredicate(format:"deliverer == 'undefined' OR deliverer == '\(username!)'")
        var query = PFQuery(className:"orders", predicate: predicate)
        
 
        //get the orders
        query.findObjectsInBackgroundWithBlock({ (orderArray, error) -> Void in
            if error == nil {
            
            
                
            self.orderArray = orderArray!
            self.rowCount = orderArray!.count
                
                
            
            self.tableView.reloadData()
            } else {
                print("error")
            }
        })
        
       

        // Uncomment the following line to preserve selection between presentations
       // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
                return rowCount
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if self.orderArray != []  {
            
           
            mainDeliveryInfo = ["x":(self.orderArray[indexPath.row]["x"] as! String), "y":(self.orderArray[indexPath.row]["y"] as! String), "type":(self.orderArray[indexPath.row]["type"] as! String), "size":(self.orderArray[indexPath.row]["size"] as! String), "progress":(self.orderArray[indexPath.row]["progress"] as! String), "name":(self.orderArray[indexPath.row]["name"] as! String), "level":(self.orderArray[indexPath.row]["level"] as! String)
                , "objectId":self.orderArray[indexPath.row].objectId!! as String, "deliverer":(self.orderArray[indexPath.row]["deliverer"]! as? String)!]
            
             
            
        }
        return indexPath
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let dateRecieved = self.orderArray[indexPath.row]["createdAt"] as? NSString
        //let timeStamp = NSDateFormatter.localizedStringFromDate((dateRecieved)!, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    
      
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
       cell.textLabel?.text = (self.orderArray[indexPath.row]["time"] as! String) + ", " + (self.orderArray[indexPath.row]["progress"] as! String) + ", " + "Level " + (self.orderArray[indexPath.row]["level"] as! String) + ", " + (self.orderArray[indexPath.row]["size"] as! String) + ", " + (self.orderArray[indexPath.row]["type"] as! String)
      
        return cell
    
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let rowKey = self.orderArray[indexPath.row] as! String
            let orders = PFObject(className:"orders")
            orders.removeObjectForKey(rowKey)
            
            orders.saveInBackground()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        //else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       // }
    }
    
*/
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
