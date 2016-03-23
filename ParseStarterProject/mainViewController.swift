//
//  mainViewController.swift
//  ParseStarterProject
//
//  Created by Thomas Hamer on 23/01/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    
    @IBOutlet weak var mapDisplay: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = NSBundle.mainBundle().pathForResource("lowerGround1", ofType: "jpg")
        let gif = NSData(contentsOfFile: filePath!)
        
        
        mapDisplay.loadData(gif!, MIMEType: "image/jpg", textEncodingName: String(), baseURL: NSURL(fileURLWithPath: filePath!))
        mapDisplay.userInteractionEnabled = true;
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
