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
        warningMessage.text = ""
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
        
        if (defaults.floatForKey("STARTTIME") != 0)
        {
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
            
            var startTime2 = defaults.objectForKey("STARTTIME") as NSTimeInterval
            // Sets time label to duration of drinking session
            var currentTime = NSDate.timeIntervalSinceReferenceDate()
            var elapsedTime: NSTimeInterval = currentTime - startTime2
            let minutes = UInt8(elapsedTime / 60.0)
            timeLabel.text = "\(String(minutes)) min"
            let hours = Float(elapsedTime / 3600.0)
            
            
            // Calculates and displays BAC level to 4 decimal places in label
            var BAClevel = ((0.806 * counter * 1.2) / (0.453592 * genderConst * weightFloat)) - (0.017 * hours)
            var BAClevel2 : NSString = NSString(format: "%.04f", BAClevel)
            labelBAC.text = "Expected BAC: \(BAClevel2)"
            
            labelDrinkCount.text = "\(Int(counter))"
            
            if BAClevel < 0.02
            {
                warningMessage.text = "No significant effect on your body."
                warningMessage.backgroundColor = UIColor(red: 153/255, green: 255/255, blue: 153/255, alpha: 1.0)
            }
            else if BAClevel < 0.04
            {
                warningMessage.text = "No loss of coordination, slight euphoria and loss of shyness. Mildly relaxed and maybe a little lightheaded."
                warningMessage.backgroundColor = UIColor(red: 153/255, green: 255/255, blue: 153/255, alpha: 1.0)
            }
            else if BAClevel < 0.07
            {
                warningMessage.text = "Feeling of well-being, relaxation, lower inhibitions, sensation of warmth. Euphoria. Your behavior may become exaggerated and emotions intensified."
                warningMessage.backgroundColor = UIColor(red: 195/255, green: 255/255, blue: 154/255, alpha: 1.0)
            }
            else if BAClevel < 0.1
            {
                warningMessage.text = "Slight impairment of balance, speech, vision, reaction time, and hearing. Euphoria. Judgment and self-control are reduced, and caution, reason and memory are impaired."
                // light yellow-green
                warningMessage.backgroundColor = UIColor(red: 215/255, green: 255/255, blue: 154/255, alpha: 1.0)
            }
            else if BAClevel < 0.13
            {
                warningMessage.text = "Significant impairment of motor coordination and loss of good judgment. Speech may be slurred; balance, vision, reaction time and hearing will be impaired. Euphoria."
                // yellow
                warningMessage.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 154/255, alpha: 1.0)
                
            }
            else if BAClevel < 0.16
            {
                warningMessage.text = "Gross motor impairment and lack of physical control. Blurred vision and major loss of balance. Euphoria is reduced and dysphoria (anxiety, restlessness) is beginning to appear."
                // orange
                warningMessage.backgroundColor = UIColor(red: 255/255, green: 215/255, blue: 154/255, alpha: 1.0)
                
            }
            else if BAClevel < 0.2
            {
                warningMessage.text = "Dysphoria predominates, nausea may appear. The drinker has the appearance of a \"sloppy drunk.\""
                // red-orange
                warningMessage.backgroundColor = UIColor(red: 255/255, green: 184/255, blue: 154/255, alpha: 1.0)
            }
            else if BAClevel < 0.25
            {
                warningMessage.text = "Feeling dazed/confused or otherwise disoriented. May need help to stand/walk. If you injure yourself you may not feel the pain. The gag reflex is impaired and you can choke if you do vomit. Blackouts are likely at this level."
                warningMessage.backgroundColor = UIColor(red: 255/255, green: 164/255, blue: 154/255, alpha: 1.0)
            }
            else if BAClevel < 0.3
            {
                warningMessage.text = "All mental, physical and sensory functions are severely impaired. Increased risk of asphyxiation from choking on vomit and of seriously injuring yourself by falls or other accidents."
                warningMessage.backgroundColor = UIColor(red: 255/255, green: 131/255, blue: 117/255, alpha: 1.0)
            }
            else if BAClevel < 0.35
            {
                warningMessage.text = "STUPOR. You have little comprehension of where you are. You may pass out suddenly and be difficult to awaken."
                warningMessage.backgroundColor = UIColor(red: 249/255, green: 87/255, blue: 69/255, alpha: 1.0)
            }
            else if BAClevel < 0.4
            {
                warningMessage.text = "Coma is possible. This is the level of surgical anesthesia."
                warningMessage.backgroundColor = UIColor(red: 249/255, green: 56/255, blue: 35/255, alpha: 1.0)
            }
            else
            {
                warningMessage.text = "Onset of coma, and possible death due to respiratory arrest."
                warningMessage.backgroundColor = UIColor(red: 242/255, green: 38/255, blue: 19/255, alpha: 1.0)
            }
        }
    }

    @IBOutlet weak var labelDrinkCount: UILabel!
    
    @IBOutlet weak var warningMessage: UITextView!
    
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
    
    
    
    @IBAction func customButtonPressed(sender: AnyObject)
    {
        if (!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: defaults, repeats: true)
        }
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("alcohol") as Alcohol
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    
    
    
    
    
    
    
}
