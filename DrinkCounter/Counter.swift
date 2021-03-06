//
//  Counter.swift
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
        var drinkCount = defaults.floatForKey("COUNTER")
        labelDrinkCount.text = "\(Int(drinkCount))"
        
        // Reset warning message
        warningMessage.text = ""
        warningMessage.textColor = UIColor.whiteColor()
        
        // Adds borders and shadows to buttons
        borderMe(add1Button)
        borderMe(addCustomButton)
        borderMe(endButton)
        shadowMe(add1Button)
        shadowMe(addCustomButton)
    }
    
    /*
    *  changes color of warning message depending on number of drinks
    */
    func colorMe(warningMessage: UITextView, myRGB: Int)
    {
        warningMessage.backgroundColor = UIColor(netHex: myRGB)
        self.view.backgroundColor = UIColor(netHex: myRGB)
    }
    
    // Define all the outlets (labels and buttons) in view controller
    @IBOutlet weak var add1Button: UIButton!
    
    @IBOutlet weak var addCustomButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var warningMessage: UITextView!
    
    @IBOutlet weak var labelBAC: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var labelDrinkCount: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initializes timer
    var timer = NSTimer()
    
    
    /*
    *  When "End Session" button pushed, confirm and reset default counter
    */
    @IBAction func endSessionPushed(sender: AnyObject) {
        
        // Confirmation from user
        var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to end session? Your current data will not be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
    
            // reset counter to 0
            defaults.setObject(0, forKey: "COUNTER")
            defaults.synchronize()
            
            // reset timer
            self.timer.invalidate()
            
            // return to login screen
            let vc = myStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
    *  Continuously updates in background
    */
    func update() {
        
        // Grabs weight, gender, and drink count from user defaults
        if (defaults.floatForKey("STARTTIME") != 0)
        {
            var weight = defaults.objectForKey("WEIGHT") as NSString
            var gender = defaults.objectForKey("GENDER") as NSString
            var genderConst = Float()
            
            // constants used in Widmark formula
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
            var startTime = defaults.objectForKey("STARTTIME") as NSTimeInterval
            
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
            
            // Only display if BAC is greater than 0
            if BAClevel > 0
            {
                labelBAC.text = "Expected BAC: \(BAClevel2)"
            }
            else
            {
                labelBAC.text = "Expected BAC: 0"
            }
            labelDrinkCount.text = "\(Int(counter))"
            
            
            // Displays warning message and changes screen color depending on BAC
            if BAClevel < 0.02
            {
                warningMessage.text = "No significant effect on your body."
                colorMe(warningMessage, myRGB: 0x2ECC71)
            }
            else if BAClevel < 0.04
            {
                warningMessage.text = "No loss of coordination, slight euphoria and loss of shyness. Mildly relaxed and maybe a little lightheaded."
                colorMe(warningMessage, myRGB: 0x2ECC71)

            }
            else if BAClevel < 0.07
            {
                warningMessage.text = "Feeling of well-being, relaxation, lower inhibitions, sensation of warmth. Euphoria. Your behavior may become exaggerated and emotions intensified."
                colorMe(warningMessage, myRGB: 0x27AE60)
            }
            else if BAClevel < 0.1
            {
                warningMessage.text = "DO NOT DRIVE! Euphoria. Judgment and self-control are reduced, and caution, reason and memory are impaired."
                colorMe(warningMessage, myRGB: 0xF1C40F)
            }
            else if BAClevel < 0.13
            {
                warningMessage.text = "DO NOT DRIVE! Speech may be slurred; balance, vision, reaction time and hearing will be impaired. Euphoria."
                colorMe(warningMessage, myRGB: 0xF1C40F)
            }
            else if BAClevel < 0.16
            {
                warningMessage.text = "DO NOT DRIVE! Blurred vision and major loss of balance. Euphoria is reduced and dysphoria (anxiety, restlessness) begins to appear."
                colorMe(warningMessage, myRGB: 0xE67E22)
            }
            else if BAClevel < 0.2
            {
                warningMessage.text = "DO NOT DRIVE! Dysphoria predominates, nausea may appear. The drinker has the appearance of a \"sloppy drunk.\""
                colorMe(warningMessage, myRGB: 0xD35400)
            }
            else if BAClevel < 0.25
            {
                warningMessage.text = "DO NOT DRIVE! Feeling dazed/confused or otherwise disoriented. The gag reflex is impaired and you can choke if you do vomit. Blackouts are likely at this level."
                colorMe(warningMessage, myRGB: 0xE74C3C)
            }
            else if BAClevel < 0.3
            {
                warningMessage.text = "DO NOT DRIVE! Increased risk of asphyxiation from choking on vomit and of seriously injuring yourself by falls or other accidents."
                colorMe(warningMessage, myRGB: 0xC0392B)
            }
            else if BAClevel < 0.35
            {
                warningMessage.text = "STUPOR. DO NOT DRIVE! You have little comprehension of where you are. You may pass out suddenly and be difficult to awaken."
                colorMe(warningMessage, myRGB: 0x8C0000)
            }
            else if BAClevel < 0.4
            {
                warningMessage.text = "DO NOT DRIVE! Coma is possible. This is the level of surgical anesthesia."
                colorMe(warningMessage, myRGB: 0x780000)
            }
            else
            {
                warningMessage.text = "DO NOT DRIVE! Onset of coma, and possible death due to respiratory arrest."
                colorMe(warningMessage, myRGB: 000000)
            }
        }
    }
    
    // When add 1 button is press, start timer if not already running and update count
    @IBAction func EZButtonPressed(sender: AnyObject)
    {
        if (!timer.valid)
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: defaults, repeats: true)
        }
        updateCount(1.0)
    }
    
    
    // If time has not already started, start when custom drink button is pressed
    @IBAction func customButtonPressed(sender: AnyObject)
    {
        if (!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: defaults, repeats: true)
        }
    }
    
    
    
    
    
    
    
    
    
}
