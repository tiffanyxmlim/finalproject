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
    
    @IBAction func buttonStartDrinking(sender: AnyObject) {
    }
    @IBAction func buttonRegisterPressed(sender: AnyObject)
    {

    }
    
    
}

