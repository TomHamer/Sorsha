//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
var currentUser = ""




class ViewController: UIViewController {
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var headTitle: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var backgroundDisplay: UIWebView!
    
    
    func fadeOut() {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.register.alpha = 0
            self.signIn.alpha = 0
            self.subTitle.alpha = 0
            
            }) { (done) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.backgroundDisplay.alpha = 0
                    }) { (success) -> Void in
                        UIView.animateWithDuration(2, animations: { () -> Void in
                            if success == true {
                                
                                self.headTitle.alpha = 0
                            }
                            
                        })
                        
                }
                
        }

        
    }
    
    
    
    
    @IBAction func registerAction(sender: AnyObject) {
        
        fadeOut()
        
        
        let seconds = 4.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.performSegueWithIdentifier("registerSegue", sender: nil)
            
        })
        
    }
    @IBAction func signInAction(sender: AnyObject) {
        
        fadeOut()
        
        let seconds = 4.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.performSegueWithIdentifier("signInSegue", sender: nil)
            
        })
        
    }
    override func viewWillDisappear(animated: Bool) {
        
        //reverse animations
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("defaultUserData")
        
        self.backgroundDisplay.alpha = 0
        self.register.alpha = 0
        self.signIn.alpha = 0
        self.subTitle.alpha = 0
        self.headTitle.alpha = 0
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //set up background
        
        let filePath = NSBundle.mainBundle().pathForResource("ezgif.com-resize", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        
        backgroundDisplay.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL(fileURLWithPath: filePath!))
        backgroundDisplay.userInteractionEnabled = false;
        
        register.layer.cornerRadius = 5
        signIn.layer.cornerRadius = 5
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
      UIView.animateWithDuration(2, animations: { () -> Void in
        self.headTitle.alpha = 0.9
        }) { (done) -> Void in
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.backgroundDisplay.alpha = 1
            }) { (success) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    if success == true {
                    self.register.alpha = 0.85
                    self.signIn.alpha = 0.85
                    
                    self.subTitle.alpha = 0.9
                    }
                    
                })
            
            }
        
        }
        
        
    }

    
    
}

