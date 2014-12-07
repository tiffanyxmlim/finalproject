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
        
        borderMe(Submit)
    }
    
    @IBOutlet weak var Submit: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    // Define array of genders
    var gender = ["", "Female", "Male"]
    
    var genderPick = String()
    
    // Indicator variable that user changed picker value
    var pickerchanged: Int = 0
    
    /*
    *  Resigns keyboard when return button pressed
    */
    @IBAction func nameReturn(sender: AnyObject) {
        nameTextField.resignFirstResponder()
    }
    
    /*
    *  Resigns keyboard when return button pressed
    */
    @IBAction func weightReturn(sender: AnyObject) {
        weightTextField.resignFirstResponder()
    }
    
    /*
    *  Sets one component (gender) for pickerview
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1
    }
    
    /*
    *  Sets number of rows (3) for pickerview
    */
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component:Int) -> Int
    {
        return gender.count
    }
    
    /*
    *  Sets titles for each row (gender) in pickerview
    */
    func pickerView(pickerView: UIPickerView!, titleForRow row:Int, forComponent component: Int) -> String!
    {
        return gender[row]
    }
    
    /*
    *  When user selects row in pickerview, update genderpick
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // Indicate that user changed picker value
        pickerchanged = 1
        
        // Set NSUserDefault for Gender
        genderPick = gender[row]
    }
    
    /*
    *  Changes font in pickerview
    */
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = gender[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    /*
    *  When registration button pressed, check for errors and alert accordingly
    */
    @IBAction func buttonRegisterPress(sender: AnyObject) {
        var name = nameTextField.text
        var weight = weightTextField.text
        var num = weight.toInt()
        
        if (name == "")
        {
            alertMe("Register Failed!", "Please enter your name.")
        }
        else if (weight == "" || num == nil || num < 50 || num > 800)
        {
            alertMe("Register Failed!", "Please enter a valid weight.")
        }
        else if (pickerchanged == 0 || genderPick == "")
        {
            alertMe("Register Failed!", "Please select a gender.")
        }
        else
        {
            // Set NSUserDefaults for Name, Weight, and Gender
            defaults.setObject(name, forKey: "NAME")
            defaults.setObject(weight, forKey: "WEIGHT")
            defaults.setObject(genderPick, forKey: "GENDER")
            
            // Reset drink counter
            defaults.setFloat(0, forKey: "COUNTER")
            
            defaults.synchronize()
            
            alertMe("Success!", "You have updated your settings.")
            
            // Segue to Log In Screen
            let vc = myStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
}


