//
//  Register.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 11/30/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Register: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var Submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        borderMe(Submit)
    }
    
    var gender = ["", "Female", "Male"]
    
    // Indicator variable that user changed picker value
    var pickerchanged: Int = 0
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!

    @IBAction func nameReturn(sender: AnyObject) {
        nameTextField.resignFirstResponder()
    }
    
    @IBAction func weightReturn(sender: AnyObject) {
        weightTextField.resignFirstResponder()
    }
    
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
        defaults.setObject(genderPick, forKey: "GENDER")
        defaults.synchronize()
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = gender[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    
    @IBAction func buttonRegisterPress(sender: AnyObject) {
        var name: NSString = nameTextField.text as NSString
        var weight: String = weightTextField.text
        var gender = defaults.objectForKey("GENDER") as NSString
        var num = weight.toInt()
        
        // Retract the keyboard
        nameTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        
        if (nameTextField.text == "")
        {
            alertMe("Register Failed!", "Please enter your name.")
        }
        else if (weightTextField.text == "" || num == nil || num < 50 || num > 800)
        {
            alertMe("Register Failed!", "Please enter a valid weight.")
        }
        else if (pickerchanged == 0 || gender == "")
        {
            alertMe("Register Failed!", "Please select a gender.")
        }
        else
        {
            // Set NSUserDefaults for Name and Weight
            defaults.setObject(name, forKey: "NAME")
            defaults.setObject(weight, forKey: "WEIGHT")
            defaults.setFloat(0, forKey: "COUNTER")
            defaults.synchronize()
            
            alertMe("Success!", "You have updated your settings.")
            
            // Segue to Log In Screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }

    
    
    
}


