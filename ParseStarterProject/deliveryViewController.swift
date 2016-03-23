//
//  deliveryViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

//new coffee orders should really be handled through push, where a direct message is sent between the customer and waiter. It is too expensive in the current algorithm, where the app refreshes from the server every 5 seconds.



import UIKit
import Parse
var coffeeDeliveryTime = 15
var mainDeliveryInfo:[String:String] = ["":""]



class deliveryViewController: UIViewController {
    @IBOutlet weak var warningIcon: UIImageView!
    func refreshOrders() {
        //need also to check if order exists here.
        let predicate = NSPredicate(format:"deliverer == 'undefined'")
        let query = PFQuery(className: "orders", predicate: predicate)
        query.getFirstObjectInBackgroundWithBlock { (order, error) -> Void in
            
            if error == nil {
                if order != nil {
                self.warningIcon.hidden = false
                }
            } else {
              
            }
        }
        
    }
    var deliveryStatus = ""
   
    @IBOutlet weak var takeOnOrderButton: UIButton!
    @IBOutlet weak var nameOfDeliverer: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var coffeeRequestMarker: UIImageView!
    
    @IBAction func takeOnOrder(sender: AnyObject) {
        
        if mainDeliveryInfo != ["":""] {
       
        let query = PFQuery(className:"orders")
        query.getObjectInBackgroundWithId(mainDeliveryInfo["objectId"]!) { (order, error) -> Void in
            if error == nil && order != nil{
             
                print(PFUser.currentUser()!.username)
                order!["deliverer"] = PFUser.currentUser()!.username
                
                self.takeOnOrderButton.hidden = true
                
                order?.saveInBackgroundWithBlock({ (worked, error) -> Void in
                   
                    if worked == true {
                        print("good")
                    } else {
                        print(error?.description)
                    }
                })
            } else {
                
                self.alertUser("Error", message: (error?.description)!)
                
            }
            }
        
        } else {
            print("failed")
        }
    }
    @IBAction func historyPress(sender: AnyObject) {
        alertUser("Sorry", message: "This feature is not available on RUSH Alpha 1.0")
    }
    // marker animations
    func flash() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.coffeeRequestMarker.alpha = 0.9
            }) { (success) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.coffeeRequestMarker.alpha = 0.1
                })
                
        }
    }
    func animateMarker() {
        
        var timer = NSTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target:self, selector: Selector("flash"), userInfo: nil, repeats: true)
        var timer2 = NSTimer()
        
            }
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func getAndSortRequests() {
        
        
        
     // var query = PFQuery(className:"orders")
        //get the orders
     //var orderArray = query.findObjects()
     /*   for i in orderArray! {
              print(i)
            
        } */
        //get the active delivery people
        let currentUser = PFUser.currentUser();
        if ((currentUser) != nil) {
            // do stuff with the user
        } else {
            // show the signup or login page
        }
        //use modulas to hand out the orders
       
    
        
        
    }
    func updateStatus() {
        
    }
    
    @IBOutlet weak var statusText: UILabel!
    @IBAction func updateStatus(sender: AnyObject) {
        
        //statuses are: "order recieved"/orderRecieved, "coffee is being made"/beingMade, "coffee is being delivered"/beingDelivered
      if deliveryStatus == "orderRecieved" {
        
          statusText.text = "beingMade"
        let query = PFQuery(className:"orders")
        query.getObjectInBackgroundWithId(mainDeliveryInfo["objectId"]!) { (order, error) -> Void in
            if error == nil && order != nil{
                order!["status"] = "beingMade"
            } 
        }
          deliveryStatus = "beingMade"
        
       }
       
        
    }
    override func viewDidAppear(animated: Bool) {
        
        refreshOrders()
        
         var refreshOrdersTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "refreshOrders", userInfo: nil, repeats: true)
        var refresh = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "refreshOrders", userInfo: nil, repeats: true)
        getAndSortRequests()
        animateMarker()
        nameLabel.text = currentUser
        if mainDeliveryInfo != ["":""] {
            if mainDeliveryInfo["deliverer"]! == PFUser.currentUser()!.username {
                takeOnOrderButton.hidden = true
            }
            if mainDeliveryInfo["deliverer"]! == "undefined" {
                takeOnOrderButton.hidden = false
            }
            deliveryStatus = mainDeliveryInfo["progress"]! as String
            
            let xString = mainDeliveryInfo["x"]
            let yString = mainDeliveryInfo["y"]
            let xFloat = Float(xString!)
            let yFloat = Float(yString!)
            print(xFloat)
            let xTransformed = xFloat!*0.51 - Float(12.69)
            let yTransformed = yFloat!*(0.51) + Float(62.218)
           
           coffeeRequestMarker.frame.origin.x = CGFloat(xTransformed)
           coffeeRequestMarker.frame.origin.y = CGFloat(yTransformed)
           level = Int(Float(mainDeliveryInfo["level"]!)!)
           nameLabel.text = mainDeliveryInfo["name"]
           orderLabel.text = mainDeliveryInfo["type"]
           sizeLabel.text = mainDeliveryInfo["size"]
            print(mainDeliveryInfo["deliverer"]! )
            
            if level == 0 {
                self.mapView.image = UIImage(named: "lowerGround1.jpg")
                
            }
            if level == 1 {
                self.mapView.image = UIImage(named: "groundFloor1.jpg")

            }
            if level == 2 {
                self.mapView.image = UIImage(named: "firstFloorPlan1.jpg")
                
            }
            if level == 3 {
                self.mapView.image = UIImage(named: "secondFloor1.jpg")
                
            }
            if level == 4 {
                self.mapView.image = UIImage(named: "thirdFloor1.jpg")
                
            }
            if level == 5 {
                self.mapView.image = UIImage(named: "fourthFloor1.jpg")
                
            }

        }
    }
    
    
    
        
        
  
    @IBAction func bringUpMenu(sender: AnyObject) {
        
        UIView.animateWithDuration(1, animations: { () -> Void in
        self.menuBackground.frame = CGRectMake(self.menuBackground.frame.origin.x + 294, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
        self.deliverySessionsButton.frame = CGRectMake(self.deliverySessionsButton.frame.origin.x + 294, self.deliverySessionsButton.frame.origin.y, self.deliverySessionsButton.frame.width, self.deliverySessionsButton.frame.height)
        self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x + 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
        self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x + 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
        self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x + 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
        })
    }
    @IBOutlet weak var menuBackground: UIImageView!
    @IBOutlet weak var deliverySessionsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        self.view.addGestureRecognizer(tap)
        
view.userInteractionEnabled = true
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func handleTap(recognizer: UITapGestureRecognizer){
      if menuBackground.frame.origin.x == 0 {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.menuBackground.frame = CGRectMake(self.menuBackground.frame.origin.x - 294, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
            self.deliverySessionsButton.frame = CGRectMake(self.deliverySessionsButton.frame.origin.x - 294, self.deliverySessionsButton.frame.origin.y, self.deliverySessionsButton.frame.width, self.deliverySessionsButton.frame.height)
            self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x - 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
            self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x - 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
             self.nameOfDeliverer.frame = CGRectMake(self.nameOfDeliverer.frame.origin.x - 294, self.nameOfDeliverer.frame.origin.y, self.nameOfDeliverer.frame.width, self.nameOfDeliverer.frame.height)
            self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x - 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
        })
} 
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
