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
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var labelName: UILabel! = nil
    
    @IBOutlet weak var Start: UIButton!
    
    /*
    **  Initializes buttons and borders for welcome screen
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set name to default settings
        if (labelName.text != nil && defaults.objectForKey("NAME") != nil)
        {
            labelName.text = defaults.objectForKey("NAME") as NSString
        }
        
        // Reset start time
        defaults.setFloat(0, forKey: "STARTTIME")
        defaults.synchronize()
        
        borderMe(registerButton)
    }
    
    
    /*
    *  When "Start Drinking" button is pressed, check for existing user then redirect user to counter screen
    */
    @IBAction func startButton(sender: AnyObject)
    {
        // If the user has never registered and is not in system, alert and prompt for registration
        if defaults.objectForKey("NAME") == nil
        {
            alertMe("Oops! There's no existing user in our system.","Please register before beginning to drink.")
        }
        else
        {
            // Segue to navigation controller-- counter screen
            let vc = myStoryboard.instantiateViewControllerWithIdentifier("navControl") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    /*
    *  When register button is pressed, redirect user to registration screen
    */
    @IBAction func registerPressed(sender: AnyObject)
    {
        // Segue to Registration Screen
        let vc = myStoryboard.instantiateViewControllerWithIdentifier("register") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

