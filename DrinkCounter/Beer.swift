//
//  Beer.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Beer: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var myPicker: UIPickerView!

    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var beerLabel: UILabel!
    
    @IBOutlet weak var ContainerView: UIImageView!
    
    @IBOutlet weak var Submit: UIButton!

    /*
    *  Run function on load to set up font and labels
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 1.0
        sliderround = 1.0

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        
        drinkLabel.text = ""
        quantityLabel.text = "1"
        beerLabel.text = ""
        
        borderMe(Submit)
    }
    
    // initializes the slider for servings and sets slider value equal to a variable
    var sliderround = Float()
    
    @IBOutlet weak var slider: UISlider!
    
    /*
    *  When slider changed, update value and label
    */
    @IBAction func sliderChanged(sender: AnyObject)
    {
        sliderround = round(10*slider.value)/10
        quantityLabel.text = "\(sliderround)"
    }
    
    // Indicator that picker was changed
    var pickerchanged: Int = 0
    
    // Defines rows of the picker
    let beerData = [
        ["TYPE", "Light", "Regular", "IPA", "Ale", "Stout"],
        
        ["SIZE", "Solo cup", "Can", "Bottle", "Stein"]
    ]
    
    // Used for calculating the number of standard drinks
    let containerVol: [Float] = [0, 16, 12, 12, 10]
    let beerABV: [Float] = [0, 0.042, 0.06, 0.07, 0.05, 0.08]
    var alcoholConsumed: Float = 0
    
    /*
    *  sets picker to have two columns filled with above beerData
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return beerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int
    {
        return beerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row:Int, forComponent component: Int) -> String!
    {
        return beerData[component][row]
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
    
    /*
    *  Sets fonts for picker
    */
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = beerData[component][row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    var containertry = ""
    var beertry = ""
    
    /*
    *  Update labels and image displayed on screen
    */
    func updateLabels()
    {
        beertry = beerData[0][myPicker.selectedRowInComponent(0)]
        containertry = beerData[1][myPicker.selectedRowInComponent(1)]
        
        if beertry != "TYPE"
        {
            drinkLabel.text = beertry
            beerLabel.text = "Beer"
        }
        else
        {
            drinkLabel.text = ""
            beerLabel.text = ""
        }
        
        switch containertry{
        case "SIZE": return ContainerView.image = nil
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.png")
        case "Can": return ContainerView.image = UIImage(named: "beercan.png")
        case "Bottle": return ContainerView.image = UIImage(named: "beerbottle.png")
        case "Stein": return ContainerView.image = UIImage(named: "stein.png")

        default: return
        }
    }
    
    /*
    *  When picker is changed, update labels as above
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    /*
    *  Error checking on submit
    */
    @IBAction func beersubmit(sender: AnyObject) {
        var message = String()
        
        if (pickerchanged == 0)
        {
            message = "Please select a beer and container."
        }
        else if (beertry == "TYPE")
        {
            message = "Please select a beer."
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
            
            // calculates number of standard drinks consumed
            alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * sliderround * beerABV[myPicker.selectedRowInComponent(0)] / 14
            
            // updates drink counter
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
