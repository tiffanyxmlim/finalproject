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
    
    @IBOutlet weak var drinklabel: UILabel!

    @IBOutlet weak var containerlabel: UILabel!
    
    @IBOutlet weak var quantitylabel: UILabel!
    
    @IBOutlet weak var ContainerView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        myPicker.delegate = self
        myPicker.dataSource = self
        
        drinklabel.text = ""
        containerlabel.text = ""
        quantitylabel.text = ""
    }
    
    var pickerchanged: Int = 0
    
    let beerData = [
        ["", "Light Beer", "Regular Beer", "IPA", "Ale", "Stout"],
        
        ["", "Solo cup", "Can", "Bottle", "Stein",],
        
        ["", "0.5", "1", "2", "3", "4", "5"]
    ]
    
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
        let containerPicked = beerData[1][myPicker.selectedRowInComponent(1)]
        let quantityPicked = beerData[2][myPicker.selectedRowInComponent(2)]
        drinklabel.text = beerPicked
        containerlabel.text = containerPicked
        quantitylabel.text = quantityPicked
        
        switch containerPicked{
        case "Solo cup": return ContainerView.image = UIImage(named: "solocup.jpg")
        case "Can": return ContainerView.image = UIImage(named: "beercan.jpg")
        case "Bottle": return ContainerView.image = UIImage(named: "beerbottle.jpg")
        case "Stein": return ContainerView.image = UIImage(named: "stein.jpg")

        default: return
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerchanged = 1
        updateLabels()
    }
    
    @IBAction func beersubmit(sender: AnyObject) {
        var beer: String = drinklabel.text!
        var container: String = containerlabel.text!
        var quantity: String = quantitylabel.text!
        var message = String()
        
        
        if (pickerchanged == 0)
        {
            message = "Please select a wine and container."
        }
        else if (beer == "")
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
