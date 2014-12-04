//
//  ViewController.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 11/29/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelWelcome: UILabel! = nil
    
    @IBOutlet weak var labelName: UILabel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if (labelName.text != nil && defaults.objectForKey("NAME") != nil){
            labelName.text = defaults.objectForKey("NAME") as NSString
        }
        defaults.setFloat(0, forKey: "STARTTIME")
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startButton(sender: AnyObject)
    {
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("NAME") == nil
        {
            // Alert if user did not enter their name
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Oops! There's no existing user in our system."
            alertView.message = "Please register before beginning to drink."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else
        {
            // Segue to navigation controller-- counter screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("navControl") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func registerPressed(sender: AnyObject)
    {
        // Segue to Registration Screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("register") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

