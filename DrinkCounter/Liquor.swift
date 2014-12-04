//
//  Liquor.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Liquor:
    UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    enum PickerComponent:Int{
        case beers = 0
        case containers = 1
    }
    
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var ContainerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
    }
    
    
    var pickerchanged: Int = 0
    var containertry = ""
    var liquortry = ""
    var quantitytry = ""
    
    let liquorData = [
        ["Type", "Rum", "Vodka", "Tequila", "Fireball", "Gin", "Bailey's", "Whiskey"],
        
        ["Container", "Shotglass", "Solocup", "Martini"],
        
        ["#", "1", "0.25", "0.5", "0.75", "1", "2", "3"]
    ]
    
    let containerVol: [Float] = [0, 1.5, 16, 8.8]
    let liquorABV: [Float] = [0, 0.4, 0.4, 0.4, 0.33, 0.45, 0.17, 0.43]
    let multipleFactor: [Float] = [0, 1, 0.25, 0.5, 0.75, 1, 2, 3]
    var alcoholConsumed: Float = 0
    
    var liquorPick = NSString()
    var containerPick = NSString()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return liquorData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int
    {
        return liquorData[component].count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row:Int, forComponent component: Int) -> String!
    {
        return liquorData[component][row]
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        switch component{
        case 0: return 110
        case 1: return 130
        case 2: return 60
        default: return 22
        }
    }
    
    func updateLabels()
    {
        let liquorPicked = liquorData[0][myPicker.selectedRowInComponent(0)]
        liquortry = liquorData[0][myPicker.selectedRowInComponent(0)]
        let containerPicked = liquorData[1][myPicker.selectedRowInComponent(1)]
        containertry = liquorData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = liquorData[2][myPicker.selectedRowInComponent(2)]
        quantitytry = liquorData[2][myPicker.selectedRowInComponent(2)]
        
        alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * multipleFactor[myPicker.selectedRowInComponent(2)] * liquorABV[myPicker.selectedRowInComponent(0)] / 14
        
        switch containerPicked{
        case "Solocup": return ContainerView.image = UIImage(named: "solocup.png")
        case "Shotglass": return ContainerView.image = UIImage(named: "shotglass.png")
        case "Martini": return ContainerView.image = UIImage(named: "martini.png")
        default: return
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    @IBAction func liquorsubmit(sender: AnyObject) {
        var liquor: String = liquortry
        var container: String = containertry
        var quantity: String = quantitytry
        
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a liquor and container."
        }
        else if (liquor == "Type")
        {
            message = "Please select a liquor."
        }
        else if (container == "Container")
        {
            message = "Please select a container."
        }
        else if (quantity == "#")
        {
            message = "Please select a quantity."
        }
        else
        {
            message = "You have entered a drink."
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = message
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
        
        if (message != "You have entered a drink.")
        {
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Error"
            alertView.message = message
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
