//
//  Functions.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 12/6/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import Foundation
import UIKit

// Sets global variables for Defaults and our Main Storyboard
var defaults = NSUserDefaults.standardUserDefaults()
var myStoryboard = UIStoryboard(name: "Main", bundle: nil)

/*
*  Adds a border to button
*/
func borderMe(buttonToBorder: UIButton)
{
    buttonToBorder.backgroundColor = UIColor.clearColor()
    buttonToBorder.layer.cornerRadius = 5
    buttonToBorder.layer.borderWidth = 1
    buttonToBorder.layer.borderColor = UIColor.whiteColor().CGColor
}

/*
*  Adds a shadow to button
*/
func shadowMe(buttonToShadow: UIButton)
{
    buttonToShadow.layer.shadowColor = UIColor.blackColor().CGColor
    buttonToShadow.layer.shadowOffset = CGSizeMake(3, 3)
    buttonToShadow.layer.shadowRadius = 5
    buttonToShadow.layer.shadowOpacity = 0.75
}

/*
*  Updates the default drink count with a float
*/
func updateCount(alcoholConsumed: Float)
{
    var oldCounter = defaults.floatForKey("COUNTER")
    var newCounter = oldCounter + alcoholConsumed
    defaults.setObject(newCounter, forKey: "COUNTER")
    if (defaults.floatForKey("STARTTIME") == 0)
    {
        var startTime = NSDate.timeIntervalSinceReferenceDate()
        defaults.setObject(startTime, forKey: "STARTTIME")
        defaults.synchronize()
    }
}

/*
*  Adds an alert with a title and message
*/
func alertMe(alertTitle: String, alertMessage: String)
{
    var alertView: UIAlertView = UIAlertView()
    alertView.title = alertTitle
    alertView.message = alertMessage
    alertView.addButtonWithTitle("OK")
    alertView.show()
}

/*
*  Adds an extension to UIColor, allowing us to use RGB or Hex values
*/
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}







