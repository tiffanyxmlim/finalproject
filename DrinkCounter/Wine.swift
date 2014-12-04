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
        
        drinkLabel.text = ""
        containerLabel.text = ""
        quantityLabel.text = ""
    }
    
    var pickerchanged: Int = 0
    
    let wineData = [
        ["", "Standard", "White", "Red", "Cooler", "Dessert", "Rose", "Port"],
        ["", "Solo cup", "Wine glass", "Shot glass", "Bottle", "Martini", "Stein", "Can"],
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
        case 0: return 110
        case 1: return 130
        case 2: return 60
        default: return 22
        }
    }
    
    func updateLabels()
    {
        let winePicked = wineData[0][myPicker.selectedRowInComponent(0)]
        let containerPicked = wineData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = wineData[2][myPicker.selectedRowInComponent(2)]
        drinkLabel.text = winePicked
        containerLabel.text = containerPicked
        quantityLabel.text = quantityPicked
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
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a wine and container."
        }
        else if (wine == "")
        {
            message = "Please select a wine."
        }
        else if (container == "")
        {
            message = "Please select a container."
        }
        else if (quantity == "")
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
