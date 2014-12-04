//
//  Beer.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class Beer: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum PickerComponent:Int{
        case beers = 0
        case containers = 1
    }

    @IBOutlet weak var myPicker: UIPickerView!

    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var beerLabel: UILabel!
    
    @IBOutlet weak var ContainerView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        
        drinkLabel.text = ""
        quantityLabel.text = ""
        beerLabel.text = ""
    }
    
    var pickerchanged: Int = 0
    var containertry = ""
    var beertry = ""
    var quantitytry = ""
    
    let beerData = [
        ["TYPE", "Light", "Regular", "IPA", "Ale", "Stout"],
        
        ["SIZE", "Solo cup", "Can", "Bottle", "Stein"],
        
        ["#", "1", "0.5", "1", "2", "3", "4", "5"]
    ]
    
    let containerVol: [Float] = [0, 16, 12, 12, 10]
    let beerABV: [Float] = [0, 0.042, 0.06, 0.07, 0.05, 0.08]
    let multipleFactor: [Float] = [0, 1, 0.5, 1, 2, 3, 4, 5]
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
    
    func updateLabels()
    {
        let beerPicked = beerData[0][myPicker.selectedRowInComponent(0)]
        beertry = beerData[0][myPicker.selectedRowInComponent(0)]
        let containerPicked = beerData[1][myPicker.selectedRowInComponent(1)]
        containertry = beerData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = beerData[2][myPicker.selectedRowInComponent(2)]
        quantitytry = beerData[2][myPicker.selectedRowInComponent(2)]
        
        
        if (beerPicked != "TYPE" && quantityPicked != "#" && containerPicked != "SIZE")
        {
            drinkLabel.text = beerPicked
            quantityLabel.text = "x     " + quantityPicked
            beerLabel.text = "Beer"
        }
        //containerlabel.text = containerPicked
        
        alcoholConsumed = containerVol[myPicker.selectedRowInComponent(1)] * 28.3495231 * multipleFactor[myPicker.selectedRowInComponent(2)] * beerABV[myPicker.selectedRowInComponent(0)] / 14
        
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
        var quantity: String = quantitytry
        //var beer: String = drinklabel.text!
        
        //var container: String = containerlabel.text!
        //var quantity: String = quantitylabel.text!
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a beer and container."
        }
        else if (beer == "Type")
        {
            message = "Please select a beer."
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
