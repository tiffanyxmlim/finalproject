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
        // Do any additional setup after loading the view.
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        labelDrinkCount.text = NSString(format: "%.01f", defaults.floatForKey("COUNTER"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 //   var drinkCounter: Float = 0
    
    var startTime = NSTimeInterval()
    
    var timer = NSTimer()
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var labelBAC: UILabel!
    
    @IBAction func endSessionPushed(sender: AnyObject) {
        var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to end session? Your current data will not be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
            
            
            
            
            
            
       //     self.drinkCounter = 0
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(0, forKey: "COUNTER")
            defaults.synchronize()
            
            
            
            self.timer.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func update() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        timeLabel.text = "\(String(minutes)) min"
        let hours = Float(elapsedTime / 3600.0)
        
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
        var BAClevel = ((0.806 * counter * 1.2) / (0.453592 * genderConst * weightFloat)) - (0.017 * hours)
        var BAClevel2 : NSString = NSString(format: "%.04f", BAClevel)
     //   if counter != 0
     //   {
            labelBAC.text = "Your current BAC: \(BAClevel2)"
     //   }
    }
    

    @IBOutlet weak var labelDrinkCount: UILabel!
    
    @IBAction func EZButtonPressed(sender: AnyObject)
    {
        var alert = UIAlertController(title: "Confirm", message: "Add 1 drink?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (alertAction) -> Void in
            var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var oldCounter = defaults.floatForKey("COUNTER")
            var newCounter = oldCounter + 1
            defaults.setObject(newCounter, forKey: "COUNTER")
            defaults.synchronize()
            
            
      //      self.drinkCounter++
            self.labelDrinkCount.text = "\(newCounter)"
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        if (!timer.valid) {
            let aSelector : Selector = "update"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
}
