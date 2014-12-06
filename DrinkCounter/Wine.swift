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
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var wineLabel: UILabel!
    
    @IBOutlet weak var Submit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 1.0
        sliderround = 1.0

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        
        drinkLabel.text = ""
        quantityLabel.text = "1"
        wineLabel.text = ""
        
        borderMe(Submit)
    }
    var sliderround = Float()
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(sender: AnyObject)
    {
        sliderround = round(10*slider.value)/10
        quantityLabel.text = "\(sliderround)"
    }
    var pickerchanged: Int = 0
    
    let wineData = [
        ["TYPE", "White", "Red", "Cooler", "Dessert", "Rose", "Port"],
        ["SIZE", "Solo cup", "Wine glass"]
    ]
    
    let wineABV: [Float] = [0, 0.11, 0.115, 0.06, 0.14, 0.105, 0.2]
    let containerVol: [Float] = [0, 16, 6]
    
    var alcoholConsumed: Float = 0
    
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
        case 0: return 150
        case 1: return 160
        default: return 22
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = wineData[component][row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    var containertry = ""
    var winetry = ""
    
    func updateLabels()
    {
        winetry = wineData[0][myPicker.selectedRowInComponent(0)]
        containertry = wineData[1][myPicker.selectedRowInComponent(1)]
        
        if winetry != "TYPE"
        {
            drinkLabel.text = winetry
            wineLabel.text = "Wine"
        }
        else
        {
            drinkLabel.text = ""
            wineLabel.text = ""
        }
        
        switch containertry{
        case "SIZE": return ContainerView.image = nil
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.png")
        case "Wine glass": return ContainerView.image = UIImage(named: "wineglass.png")
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
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a wine and container."
        }
        else if (winetry == "TYPE")
        {
            message = "Please select a wine."
        }
        else if (containertry == "SIZE")
        {
            message = "Please select a container."
        }
        else if (slider.value < 0.1)
        {
            message = "Please select a quantity."
        }
        else
        {
            message = "You have entered a drink."
            alertMe("Success!", message)
            
            alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * sliderround * wineABV[myPicker.selectedRowInComponent(0)] / 14
            
            updateCount(alcoholConsumed)
            
            // Pop to root view controller ("counter" screen)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        
        if (message != "You have entered a drink.")
        {
            alertMe("Error", message)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
