//
//  homepage.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 11/30/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Counter: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set label for drink count when screen loads, as an integer
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var drinkCount = defaults.floatForKey("COUNTER")
        labelDrinkCount.text = "\(Int(drinkCount))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var startTime = NSTimeInterval()
    
    var timer = NSTimer()
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var labelBAC: UILabel!
    
    @IBAction func endSessionPushed(sender: AnyObject) {
        var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to end session? Your current data will not be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // When "End Session" confirmed...
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
            
            // reset counter to 0
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(0, forKey: "COUNTER")
            defaults.synchronize()
            
            // reset timer
            self.timer.invalidate()
            
            // return to login screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    // Continuously updates in background after "Add 1 Drink" is pressed for first time
    func update() {
        
        // Grabs weight, gender, and drink count from user defaults
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var weight = defaults.objectForKey("WEIGHT") as NSString
        var gender = defaults.objectForKey("GENDER") as NSString
        var genderConst = Float()
        if gender == "Female"
        {
            genderConst = 0.49
        }
        else
        {
            genderConst = 0.58
        }
        var weightFloat = weight.floatValue
        var counter = defaults.floatForKey("COUNTER")
        
        
        // Sets time label to duration of drinking session
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        timeLabel.text = "\(String(minutes)) min"
        let hours = Float(elapsedTime / 3600.0)
 
        
        // Calculates and displays BAC level to 4 decimal places in label
        // the Widmark formula
        var BAClevel = ((0.806 * counter * 1.2) / (0.453592 * genderConst * weightFloat)) - (0.017 * hours)
        var BAClevel2 : NSString = NSString(format: "%.04f", BAClevel)
        labelBAC.text = "Your current BAC: \(BAClevel2)"
        
        labelDrinkCount.text = "\(Int(counter))"
        
    }

    @IBOutlet weak var labelDrinkCount: UILabel!
    
    
    // When "Add 1 Drink" is pressed...
    @IBAction func EZButtonPressed(sender: AnyObject)
    {
        // Alert popup to confirm
        var alert = UIAlertController(title: "Confirm", message: "Add 1 drink?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // If confirmed...
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (alertAction) -> Void in
            
            // Add 1 drink to counter, and synchronize with NSUserDefaults
            var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var oldCounter = defaults.floatForKey("COUNTER")
            var newCounter = oldCounter + 1
            defaults.setObject(newCounter, forKey: "COUNTER")
            
            // Display integer version of counter
            self.labelDrinkCount.text = "\(Int(newCounter))"
            
            // If timer is not running yet, start timer and update (see function above)
            if (!self.timer.valid) {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: defaults, repeats: true)
                self.startTime = NSDate.timeIntervalSinceReferenceDate()
                defaults.setObject(self.startTime, forKey: "STARTTIME")
            }
            defaults.synchronize()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        


    }
    
    
    
    
    
    
    
    
    
    
    
    
}
