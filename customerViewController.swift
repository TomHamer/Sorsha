//
//  customerViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//


import UIKit
import Parse
var currentOrderNumber: String = ""

var currentRequest = [String:String]()


var level = 0
var coffeeOrdered = false
var menuOut = false
class customerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var cancelOrderButton: UIButton!
    func refreshOrderDetails() {
        
        
        
    }
    
    func cancelOrderAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .Default, handler: { (action) -> Void in
            
            var query = PFQuery(className: "orders")
            query.whereKey("user", equalTo: PFUser.currentUser()!.username!)
            query.getFirstObjectInBackgroundWithBlock({ (order, error) -> Void in
                if error == nil {
                    print(order)
                    order?.deleteInBackgroundWithBlock({ (success, error) -> Void in
                        if error == nil {
                           
                        }
                    })
                    
                }
            })
            let order = PFObject(className: "orders")
            PFUser.currentUser()!["currentOrder"] = ""
            PFUser.currentUser()!.saveInBackground()
            order.removeObjectForKey(currentRequest["objectId"]!)
            order.saveInBackgroundWithBlock({ (success, error) -> Void in
                if error == nil {
                   print("Success")
                } else {
                    print(error)
                }
            })
            let defaults = NSUserDefaults.standardUserDefaults()
            coffeeOrdered = false
            defaults.setObject(coffeeOrdered, forKey: "coffeeOrdered")
            defaults.removeObjectForKey("currentOrderNumber")
            currentOrderNumber = ""
            defaults.removeObjectForKey("orderDetails")
            
            currentRequest = [:]
            coffeeOrdered = false
            self.manStairsButton.enabled = true
            self.scrollView.scrollEnabled = true
            self.faceButton.enabled = true
            self.navigationBar.topItem!.title = "S O R S H A"
            self.coffeeReturnButton.hidden = true
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.coffeeRequestMarker.alpha = 0
                self.placeOrderButton.alpha = 0
                self.cancelOrderButton.alpha = 0
            })
            
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            
            self.scrollView.addGestureRecognizer(tap)
            var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
            
            uilpgr.minimumPressDuration = 2.0
            
            self.scrollView.addGestureRecognizer(uilpgr)
           // gameScore.removeObjectForKey("playerName")

            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "BACK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func cancelOrder(sender: AnyObject) {
        
        
        cancelOrderAlert("CANCEL ORDER", message: "If you cancel your order, you will still be charged")
        
    }
    func centerMarker(){
        coffeeRequestMarker.center = CGPointMake(CGFloat(Float(currentRequest["x"]!)!) +  mapImageView.frame.origin.x, CGFloat(Float(currentRequest["y"]!)!) + mapImageView.frame.origin.y)
       
    }
    
    func getTime() -> String {
        
        let date = NSDate()
        let strDate = NSString(string: String(date))
        let time = strDate.substringWithRange(NSRange(location: 11, length: 8))
        return time
    }
    
    
    func setUpMap() {
            centerScrollViewContents()
        if currentRequest != [:] {
            if currentRequest["level"]! != "" {
                UIView.animateWithDuration(1, animations: { () -> Void in
                
                self.coffeeRequestMarker.alpha = 1
                    
                    })
                performSelector("centerMarker", withObject: nil, afterDelay: 0.1)
                
                
                level = Int(currentRequest["level"]!)!
            } else {
                if NSUserDefaults.standardUserDefaults().objectForKey("level") != nil {
                   level =  NSUserDefaults.standardUserDefaults().objectForKey("level") as! Int
                } else {
                    level = 1
                }
            }
            }
            
        

        
    
    
    if level == 0 {
    print("ok")
    mapImageView.image = UIImage(named: "lowerGround1.jpg")
    
    }
    if level == 1 {
    mapImageView.image = UIImage(named: "groundFloor1.jpg")
    
    }
    if level == 2 {
    mapImageView.image = UIImage(named: "firstFloorPlan1.jpg")
    
    }
    if level == 3 {
    mapImageView.image = UIImage(named: "secondFloor1.jpg")
    
    }
    if level == 4 {
    mapImageView.image = UIImage(named: "thirdFloor1.jpg")
    
    }
    if level == 5 {
    mapImageView.image = UIImage(named: "fourthFloor1.jpg")
        }
    
        mapImageView.frame = CGRectMake(0, 0, 745, 603)
        mapImageView.alpha = 0
        
        // 2
        scrollView.contentSize = CGSizeMake(745, 603)
        //   scrollView.addSubview(mapImageView)
        
        // 3
        
        
        // 4
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        // 5
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
        //set up the floor choosing items
        
        view.bringSubviewToFront(picker)
        view.bringSubviewToFront(selectFloorTitle)
        
        
        
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
    }
    
    
    
    @IBOutlet weak var coffeeReturnButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuBackground: UIImageView!
    
    @IBAction func `return`(sender: AnyObject) {
        faceButton.enabled = true
        manStairsButton.enabled = true
        scrollView.userInteractionEnabled = true
        returnButton.hidden = true

       UIView.animateWithDuration(1, animations: { () -> Void in
        
        self.picker.center = CGPointMake(self.picker.center.x, self.picker.center.y+800)
        self.selectFloorTitle.center = CGPointMake(self.selectFloorTitle.center.x, self.selectFloorTitle.center.y+800)
        }) { (success) -> Void in
        
            self.picker.userInteractionEnabled = false
            self.picker.hidden = true
            
            
            self.selectFloorTitle.hidden = true
        //set up image for animation
        
        self.picker.center = CGPointMake(self.picker.center.x, self.picker.center.y-800)
        self.selectFloorTitle.center = CGPointMake(self.selectFloorTitle.center.x, self.selectFloorTitle.center.y-800)
        }
        
        
    }
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var promotionsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBAction func bringUpMenu(sender: AnyObject) {
        if menuOut==false {
    menuOut = true
    
    UIView.animateWithDuration(1, animations: { () -> Void in
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x + 294, self.nameLabel.frame.origin.y, self.nameLabel.frame.width, self.nameLabel.frame.height)
    self.menuBackground.frame = CGRectMake(self.menuBackground.frame.origin.x + 294, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
    self.promotionsButton.frame = CGRectMake(self.promotionsButton.frame.origin.x + 294, self.promotionsButton.frame.origin.y, self.promotionsButton.frame.width, self.promotionsButton.frame.height)
    self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x + 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
    self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x + 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
    self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x + 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
    })

        }
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var placeOrderButton: UIButton!
    
    @IBOutlet weak var coffeeRequestMarker: UIImageView!
    
    var viewHasAppeared = false
    var pickerData: [String] = [String]()
    
    
   
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var faceButton: UIBarButtonItem!
    @IBOutlet weak var manStairsButton: UIButton!
   /* @IBAction func selectLevel(sender: AnyObject) {
        
        picker.userInteractionEnabled = false
        selectFloorButton.hidden = true
        selectFloorButton.enabled = false
        selectFloorTitle.hidden = true
        picker.hidden = true
        picker.bringSubviewToFront(picker)
        
        faceButton.enabled = true
        manStairsButton.enabled = true
        scrollView.userInteractionEnabled = true
        returnButton.hidden = true
        if level == 0 {
            print("ok")
            mapImageView.image = UIImage(named: "lowerGround1.jpg")
            
            
        }
        if level == 1 {
            mapImageView.image = UIImage(named: "groundFloor1.jpg")
            
        }
        if level == 2 {
            mapImageView.image = UIImage(named: "firstFloorPlan1.jpg")
           
        }
        if level == 3 {
            mapImageView.image = UIImage(named: "secondFloor1.jpg")
            
        }
        if level == 4 {
            mapImageView.image = UIImage(named: "thirdFloor1.jpg")
            
        }
        if level == 5 {
            mapImageView.image = UIImage(named: "fourthFloor1.jpg")
            
        }
        mapImageView.alpha = 0
        UIView.animateWithDuration(2, animations: { () -> Void in
            
            self.mapImageView.alpha = 0.95
            
        })
        
    }*/
    
    @IBAction func changeFloor(sender: AnyObject) {
        
        picker.userInteractionEnabled = true
        
        
        selectFloorTitle.hidden = false
        picker.hidden = false
        
        
        //blur view
   /*   let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = scrollView.bounds
        scrollView.addSubview(blurView) */
       
        returnButton.enabled = true
        faceButton.enabled = false
        manStairsButton.enabled = false
        scrollView.userInteractionEnabled = false
        
        //set up image for animation
        
        picker.center = CGPointMake(picker.center.x, picker.center.y+800)
        selectFloorTitle.center = CGPointMake(selectFloorTitle.center.x, selectFloorTitle.center.y+800)
        //animate options into focus
        returnButton.hidden = false
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            
            self.picker.center = CGPointMake(self.picker.center.x, self.picker.center.y-800)
            self.selectFloorTitle.center = CGPointMake(self.selectFloorTitle.center.x, self.selectFloorTitle.center.y-800)
            
        })

        
        
        
    }
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var selectFloorTitle: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func viewDidLayoutSubviews() {
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        centerScrollViewContents()
        if currentRequest != [:] {
            setUpMap()
                var refreshOrderTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "refreshOrderDetails", userInfo: nil, repeats: true)
                self.mapImageView.alpha = 0.95
                
        
            
        } else {
            placeOrderButton.alpha = 0
            coffeeOrdered = false
            coffeeRequestMarker.alpha = 0
        setUpMap()
            UIView.animateWithDuration(2, animations: { () -> Void in
                
                self.mapImageView.alpha = 0.95
                
            })
            
        }
        centerScrollViewContents()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("coffeeOrdered") != nil {
            coffeeOrdered =  NSUserDefaults.standardUserDefaults().objectForKey("coffeeOrdered") as! Bool
            print(currentRequest)
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("currentOrderNumber") != nil {
            
            cancelOrderButton.alpha = 1
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("currentOrderNumber") != nil {
            currentOrderNumber =  NSUserDefaults.standardUserDefaults().objectForKey("currentOrderNumber") as! String
            
            
        }
        nameLabel.text = currentUser
        if NSUserDefaults.standardUserDefaults().objectForKey("orderDetails") != nil {
        //    let query = PFUser.query()
          //  query!.whereKey("username", equalTo:PFUser.currentUser()!.username!)
           // var userDets = query!.findObjects()
         //   order - userDets[]
         //   currentRequest =  NSUserDefaults.standardUserDefaults().objectForKey("orderDetails") as! [String:String]
            print(currentRequest)
            
        }
                if currentRequest != [:] {
                var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
                
                
                scrollView.removeGestureRecognizer(uilpgr)
                nameLabel.text = currentUser
                
                let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
                self.scrollView.addGestureRecognizer(tap)
                
                placeOrderButton.alpha = 0
                
                coffeeRequestMarker.alpha = 0
                
                
                pickerData = ["Lower Ground Floor", "Ground Floor", "First Floor", "Second Floor", "Third Floor", "Fourth Floor"]
                
            } else {
                
                let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
                self.scrollView.addGestureRecognizer(tap)
                
                placeOrderButton.alpha = 0
                
                coffeeRequestMarker.alpha = 0
                
                
                pickerData = ["Lower Ground Floor", "Ground Floor", "First Floor", "Second Floor", "Third Floor", "Fourth Floor"]
                //set up long press recognition
                
                var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
                
                uilpgr.minimumPressDuration = 2.0
                
                scrollView.addGestureRecognizer(uilpgr)
                
                //Set up scroll view to scroll image
                
                
                
                
            }
        
        
       
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            print("recognised")
            if coffeeOrdered == false {
            
            coffeeOrdered = true
            coffeeRequestMarker.alpha = 1
            var touchPoint = gestureRecognizer.locationInView(self.scrollView)
            print(touchPoint)
            laidDownPointerForCoffee()
                currentRequest["x"] = String(touchPoint.x)
                currentRequest["y"] = String(touchPoint.y - 17.5)
                currentRequest["level"] = String(level)
            centerScrollViewContents()
            
            coffeeRequestMarker.center = CGPointMake(touchPoint.x, -800)
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.coffeeRequestMarker.center = CGPointMake(touchPoint.x, touchPoint.y - 17.5)
                }) { (success) -> Void in
                    
                    self.manStairsButton.enabled = false
                    self.scrollView.userInteractionEnabled = false
                    self.faceButton.enabled = false
                    
                    UIView.animateWithDuration(2, animations: { () -> Void in
                        if success == true {
                            
                            
                        }
                        
                    })
            }
            
            }
              
        }

    }
    @IBAction func returnFromCoffee(sender: AnyObject) {
        currentRequest = [:]
       
        coffeeOrdered = false
        self.manStairsButton.enabled = true
        self.scrollView.userInteractionEnabled = true
        self.faceButton.enabled = true
        navigationBar.topItem!.title = "S O R S H A"
        coffeeReturnButton.hidden = true
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.coffeeRequestMarker.alpha = 0
            self.placeOrderButton.alpha = 0
        })
    }
    func laidDownPointerForCoffee() {
        
         navigationBar.topItem!.title = "Order Coffee"
        coffeeReturnButton.hidden = false
        coffeeReturnButton.enabled = true
        
        
        UIView.animateWithDuration(1, animations: { () -> Void in
           
            self.placeOrderButton.alpha = 1
        })
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

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        level = row
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(level, forKey: "level")
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.mapImageView.alpha = 0
            
           
                        }) { (success) -> Void in
                            
        
        if level == 0 {
            
            self.mapImageView.image = UIImage(named: "lowerGround1.jpg")
            
            
        }
        if level == 1 {
            self.mapImageView.image = UIImage(named: "groundFloor1.jpg")
            
        }
        if level == 2 {
            self.mapImageView.image = UIImage(named: "firstFloorPlan1.jpg")
            
        }
        if level == 3 {
            self.mapImageView.image = UIImage(named: "secondFloor1.jpg")
            
        }
        if level == 4 {
            self.mapImageView.image = UIImage(named: "thirdFloor1.jpg")
            
        }
        if level == 5 {
            self.mapImageView.image = UIImage(named: "fourthFloor1.jpg")
            
        }
        self.mapImageView.alpha = 0
        UIView.animateWithDuration(1, animations: { () -> Void in
           
            self.mapImageView.alpha = 0.95
            
        })

        print(level)
                
        }
    }
    func handleTap(recognizer: UITapGestureRecognizer){
        if menuOut {
        menuOut = false
        print(coffeeRequestMarker.center.x)
       // coffeeRequestMarker.center = CGPointMake(CGFloat(Float(possibleRequest[0])!), CGFloat(Float(possibleRequest[1])!))
        if menuBackground.frame.origin.x == 0 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x - 294, self.nameLabel.frame.origin.y, self.nameLabel.frame.width, self.nameLabel.frame.height)
                self.menuBackground.frame = CGRectMake(self.menuBackground.frame.origin.x - 294, self.menuBackground.frame.origin.y, self.menuBackground.frame.width, self.menuBackground.frame.height)
                self.promotionsButton.frame = CGRectMake(self.promotionsButton.frame.origin.x - 294, self.promotionsButton.frame.origin.y, self.promotionsButton.frame.width, self.promotionsButton.frame.height)
                self.historyButton.frame = CGRectMake(self.historyButton.frame.origin.x - 294, self.historyButton.frame.origin.y, self.historyButton.frame.width, self.historyButton.frame.height)
                self.settingsButton.frame = CGRectMake(self.settingsButton.frame.origin.x - 294, self.settingsButton.frame.origin.y, self.settingsButton.frame.width, self.settingsButton.frame.height)
                self.paymentButton.frame = CGRectMake(self.paymentButton.frame.origin.x - 294, self.paymentButton.frame.origin.y, self.paymentButton.frame.width, self.paymentButton.frame.height)
            })
        }
        }
    }
    func centerScrollViewContents() {
        if currentRequest == [:] {
           scrollView.contentOffset = CGPoint(x: 195, y: 0)
        } else {
            manStairsButton.enabled = false
            scrollView.scrollEnabled = false
            print(Float(currentRequest["x"]!))
            
            scrollView.contentOffset = CGPoint(x: CGFloat(Float(currentRequest["x"]!)!-187.5), y:0)
            
            if coffeeOrdered {
        navigationBar.topItem!.title = "COFFEE EN ROUTE"
            } else {
                navigationBar.topItem!.title = "CONFIRM"
            }
        }
            
        
        
    }
    
    //animate marker
    
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
        
        
    }
    func alertUser(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func confirmedOrder(sender: AnyObject) {
        coffeeOrdered = true
      
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(coffeeOrdered, forKey: "coffeeOrdered")
      
    }
}
