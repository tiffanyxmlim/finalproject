//
//  Wine.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 12/3/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Wine: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var myPicker: UIPickerView!

    
    @IBOutlet weak var ContainerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        

    }
    var containertry = ""
    var pickerchanged: Int = 0
    var winetry = ""
    var quantitytry = ""
    
    let wineData = [
        ["Type", "Standard", "White", "Red", "Cooler", "Dessert", "Rose", "Port"],
        ["Container", "Solo cup", "Wine glass"],
        ["#", "0.25", "0.5", "0.75", "1", "2", "3", "4", "5"]
    ]
    
    let wineABV: [Float] = [0, 0.12, 0.11, 0.115, 0.06, 0.14, 0.105, 0.2]
    let containerVol: [Float] = [0, 16, 9]
    let multipleFactor: [Float] = [0, 0.25, 0.5, 0.75, 1, 2, 3, 4, 5]
    var alcoholConsumed: Float = 0
    
    var winePick = NSString()
    var containerPick = NSString()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return wineData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int
    {
        return wineData[component].count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row:Int, forComponent component: Int) -> String!
    {
       return wineData[component][row]
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
        let winePicked = wineData[0][myPicker.selectedRowInComponent(0)]
        winetry = wineData[0][myPicker.selectedRowInComponent(0)]
        let containerPicked = wineData[1][myPicker.selectedRowInComponent(1)]
        containertry = wineData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = wineData[2][myPicker.selectedRowInComponent(2)]
        quantitytry = wineData[2][myPicker.selectedRowInComponent(2)]

        
        alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * multipleFactor[myPicker.selectedRowInComponent(2)] * wineABV[myPicker.selectedRowInComponent(0)] / 14
        
        switch containerPicked{
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.jpg")
        case "Wine glass": return ContainerView.image = UIImage(named: "wineglass.jpg")
        default: return
        }

    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject)
    {

        var wine: String = winetry
        var container: String = containertry
        var quantity: String = quantitytry
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a wine and container."
        }
        else if (wine == "Type")
        {
            message = "Please select a wine."
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
