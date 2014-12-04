//
//  Register.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 11/30/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Register: UIViewController, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    }
    
    var gender = ["", "Female", "Male"]
    
    // Indicator variable that user changed picker value
    var pickerchanged: Int = 0
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component:Int) -> Int
    {
        return gender.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row:Int, forComponent component: Int) -> String!
    {
        return gender[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // Indicate that user changed picker value
        pickerchanged = 1
        
        // Set NSUserDefault for Gender
        var genderPick = gender[row]
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(genderPick, forKey: "GENDER")
        defaults.synchronize()
    }
    
    
    @IBAction func buttonRegisterPress(sender: AnyObject) {
        var name: NSString = nameTextField.text as NSString
        var weight: String = weightTextField.text
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var gender = defaults.objectForKey("GENDER") as NSString
        var num = weight.toInt()
        
        // Retract the keyboard
        nameTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        
        if (nameTextField.text == "")
        {
            // Alert if user did not enter their name
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Register Failed!"
            alertView.message = "Please enter your name."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (weightTextField.text == "" || num == nil || num < 50 || num > 800)
        {
            // Alert if user did not enter a positive integer for a weight
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Register Failed!"
            alertView.message = "Please enter a valid weight."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (pickerchanged == 0 || gender == "")
        {
            // Alert if user did not select a gender
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Register Failed!"
            alertView.message = "Please select a gender."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else
        {
            // Set NSUserDefaults for Name and Weight
            defaults.setObject(name, forKey: "NAME")
            defaults.setObject(weight, forKey: "WEIGHT")
            defaults.setFloat(0, forKey: "COUNTER")
            defaults.synchronize()
            
            // Alert user that they have completed registration
            var success: UIAlertView = UIAlertView()
            success.title = "Success!"
            success.message = "You have update your settings."
            success.delegate = self
            success.addButtonWithTitle("OK")
            success.show()
            
            // Segue to Log In Screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }

    
    
    
}


