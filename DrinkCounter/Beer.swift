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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 1.0

        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        
        drinkLabel.text = ""
        quantityLabel.text = "1"
        beerLabel.text = ""
        
        Submit.backgroundColor = UIColor.clearColor()
        Submit.layer.cornerRadius = 5
        Submit.layer.borderWidth = 1
        Submit.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    var sliderround = Float()
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(sender: AnyObject)
    {
        sliderround = round(10*slider.value)/10
        quantityLabel.text = "\(sliderround)"
    }
    
    var pickerchanged: Int = 0
    var containertry = ""
    var beertry = ""
    
    let beerData = [
        ["TYPE", "Light", "Regular", "IPA", "Ale", "Stout"],
        
        ["SIZE", "Solo cup", "Can", "Bottle", "Stein"]
    ]
    
    let containerVol: [Float] = [0, 16, 12, 12, 10]
    let beerABV: [Float] = [0, 0.042, 0.06, 0.07, 0.05, 0.08]
    var alcoholConsumed: Float = 0
    
    var beerPick = NSString()
    var containerPick = NSString()
    
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
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = beerData[component][row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Heiti TC", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    func updateLabels()
    {
        let beerPicked = beerData[0][myPicker.selectedRowInComponent(0)]
        beertry = beerData[0][myPicker.selectedRowInComponent(0)]
        
        let containerPicked = beerData[1][myPicker.selectedRowInComponent(1)]
        containertry = beerData[1][myPicker.selectedRowInComponent(1)]
        
        //let quantityPicked = beerData[2][myPicker.selectedRowInComponent(2)]
        //var quantityPicked = round(10*slider.value)/10
        
        
        drinkLabel.text = beerPicked
        //quantityLabel.text = "x     " + quantityPicked
        beerLabel.text = "Beer"
        
        //alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * sliderround * beerABV[myPicker.selectedRowInComponent(0)] / 14
        
        switch containerPicked{
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.png")
        case "Can": return ContainerView.image = UIImage(named: "beercan.png")
        case "Bottle": return ContainerView.image = UIImage(named: "beerbottle.png")
        case "Stein": return ContainerView.image = UIImage(named: "stein.png")

        default: return
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    @IBAction func beersubmit(sender: AnyObject) {
        
        var beer: String = beertry
        var container: String = containertry
        //var quantity: String = quantitytry
        //var beer: String = drinklabel.text!
        
        //var container: String = containerlabel.text!
        //var quantity: String = quantitylabel.text!
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a beer and container."
        }
        else if (beer == "TYPE")
        {
            message = "Please select a beer."
        }
        else if (container == "SIZE")
        {
            message = "Please select a container."
        }
        /*else if (quantity == "[#]")
        {
            message = "Please select a quantity."
        }*/
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
            alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * sliderround * beerABV[myPicker.selectedRowInComponent(0)] / 14
            
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
