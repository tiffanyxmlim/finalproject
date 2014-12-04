//
//  CustomDrink.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class CustomDrink: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ABV: UITextField!
    
    @IBOutlet weak var Volume: UITextField!

    
    @IBAction func CustomDrinkPress(sender: AnyObject) {
        var custom: String = ABV.text
        var container: String = Volume.text
        var customABV: Float = (ABV.text as NSString).floatValue
        var containerVol: Float = (Volume.text as NSString).floatValue
        //var customABV = custom.toInt()
        //var containerVol = container.toInt()
        var alcoholConsumed: Float = 0.0
        var success = String()
        //let hundred: Float = 100.0
        
        //retract keyboard
        ABV.resignFirstResponder()
        Volume.resignFirstResponder()
        
        if (ABV.text == "")
        {
            // Alert if user did not enter an ABV
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Drink Failed!"
            alertView.message = "Please enter an ABV."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (Volume.text == "")
        {
            //Alert if user did not enter volume
            var alertview: UIAlertView = UIAlertView()
            alertview.title = "Drink Failed!"
            alertview.message = "Please enter a volume of alcohol."
            alertview.delegate = self
            alertview.addButtonWithTitle("OK")
            alertview.show()
        }
            
        else if (containerVol == nil || 0 > containerVol || containerVol > 100)
        {
            //Alert if user input an invalid Volume
            var alertview: UIAlertView = UIAlertView()
            alertview.title = "Drink Failed!"
            alertview.message = "Please enter a volume between 0 and 100."
            alertview.delegate = self
            alertview.addButtonWithTitle("OK")
            alertview.show()

        }
        else if (customABV == nil || 0 > customABV || customABV > 100)
        {
            //Alert if user input an invalid ABV
            var alertview: UIAlertView = UIAlertView()
            alertview.title = "Drink Failed!"
            alertview.message = "Please enter an ABV between 0 and 100."
            alertview.delegate = self
            alertview.addButtonWithTitle("OK")
            alertview.show()
        }

        
        else
        {
            alcoholConsumed = containerVol * 28.3495231 * customABV/14
            
            success = "You have entered a drink."
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = success
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            // Add alcoholConsumed (number of Standard Drinks) to counter, and synchronize with NSUserDefaults
            var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var oldCounter = defaults.floatForKey("COUNTER")
            var newCounter = oldCounter + alcoholConsumed
            defaults.setObject(newCounter, forKey: "COUNTER")
            if (defaults.floatForKey("STARTTIME") == 0)
            {
                var startTime = NSDate.timeIntervalSinceReferenceDate()
                defaults.setObject(startTime, forKey: "STARTTIME")
                defaults.synchronize()
            }
            
            
            // Pop to root view controller ("counter" screen)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        
        if (success != "You have entered a drink.")
        {
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Error"
            alertView.message = success
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
