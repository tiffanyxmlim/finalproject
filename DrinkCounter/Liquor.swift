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
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var ContainerView: UIImageView!
    
    @IBOutlet weak var drinkLabel: UILabel!

    @IBOutlet weak var quantityLabel: UILabel!
    
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
    
    
    let liquorData = [
        ["TYPE", "Rum", "Vodka", "Tequila", "Fireball", "Gin", "Bailey's", "Whiskey"],
        
        ["SIZE", "Shot glass", "Solo cup", "Martini"]
    ]
    
    let containerVol: [Float] = [0, 1.5, 16, 8.8]
    let liquorABV: [Float] = [0, 0.4, 0.4, 0.4, 0.33, 0.45, 0.17, 0.43]
    var alcoholConsumed: Float = 0
    
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
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = liquorData[component][row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    var containertry = ""
    var liquortry = ""
    
    func updateLabels()
    {
        liquortry = liquorData[0][myPicker.selectedRowInComponent(0)]
        containertry = liquorData[1][myPicker.selectedRowInComponent(1)]

        if liquortry != "TYPE"
        {
            drinkLabel.text = liquortry
        }
        else
        {
            drinkLabel.text = ""
        }
        
        switch containertry{
        case "SIZE": return ContainerView.image = nil
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.png")
        case "Shot glass": return ContainerView.image = UIImage(named: "shotglass.png")
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
        var message = String()
        
        if (pickerchanged == 0)
        {
            message = "Please select a liquor and container."
        }
        else if (liquortry == "TYPE")
        {
            message = "Please select a liquor."
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
            
            alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * sliderround * liquorABV[myPicker.selectedRowInComponent(0)] / 14
            
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
