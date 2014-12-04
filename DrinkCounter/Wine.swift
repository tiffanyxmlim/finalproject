//
//  Wine.swift
//  DrinkCounter
//
//  Created by Tiffany Lim on 12/3/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Wine: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    enum PickerComponent:Int{
        case wines = 0
        case containers = 1
    }
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var containerLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
    }
    
    var pickerchanged: Int = 0
    
    let wineData = [
        ["", "Standard", "Light White", "Champagne", "High ABV", "Dessert"],
        ["", "Solo cup", "Wine glass", "Shot glass", "Beer Bottle", "Martini glass", "Stein", "Can"],
        ["", "0.25", "0.5", "0.75", "1", "2", "3", "4", "5"]
    ]
    
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
        case 0: return 140
        case 1: return 140
        case 2: return 60
        default: return 22
        }
    }
    
    func updateLabels()
    {
        let winePicked = wineData[0][myPicker.selectedRowInComponent(0)]
        let containerPicked = wineData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = wineData[2][myPicker.selectedRowInComponent(2)]
        drinkLabel.text = "Drink: " + winePicked
        containerLabel.text = "Container: " + containerPicked
        quantityLabel.text = "Quantity: " + quantityPicked
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject)
    {
        var wine: String = drinkLabel.text!
        var container: String = containerLabel.text!
        var quantity: String = quantityLabel.text!
        
        if (pickerchanged == 0)
        {
            // Alert if user did not select anything
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "You goofed"
            alertView.message = "Please select a wine and container."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (wine == "Drink: ")
        {
            // Alert if user did not select a type of wine
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "You goofed"
            alertView.message = "Please select a wine."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (container == "Container: ")
        {
            // Alert if user did not select a container
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "You goofed"
            alertView.message = "Please select a container."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (quantity == "Quantity: ")
        {
            // Alert if user did not select a quantity
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "You goofed"
            alertView.message = "Please select a quantity."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else
        {
            // Alert user that they have submitted a drink
            var success: UIAlertView = UIAlertView()
            success.title = "Success!"
            success.message = "You have entered a drink."
            success.delegate = self
            success.addButtonWithTitle("OK")
            success.show()
            
            // Pop to root view controller ("counter" screen)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }

    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
