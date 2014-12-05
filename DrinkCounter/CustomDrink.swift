//
//  CustomDrink.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class CustomDrink: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sliderABV.value = 0.0
        sliderVolume.value = 0.0
        labelABV.text = "0 %"
        labelVolume.text = "0"
    }
    var sliderVolumeround = Float()
    var sliderABVround = Float()
    
    @IBOutlet weak var sliderABV: UISlider!
    
    @IBOutlet weak var labelABV: UILabel!
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    @IBOutlet weak var labelVolume: UILabel!
    
    @IBAction func changeABV(sender: AnyObject)
    {
        sliderABVround = round(10 * sliderABV.value) / 10
        labelABV.text = "\(sliderABVround) %"
    }
    
    @IBAction func changeVolume(sender: AnyObject)
    {
        sliderVolumeround = round(10 * sliderVolume.value) / 10
        labelVolume.text = "\(sliderVolumeround)"
    }
    
    @IBAction func CustomDrinkPress(sender: AnyObject)
    {
        var alcoholConsumed: Float = sliderVolumeround * 28.3495231 * sliderABVround / 1400
        
        var alertView: UIAlertView = UIAlertView()
        alertView.title = "Success!"
        alertView.message = "You have entered \(sliderVolumeround) ounces of a drink with \(sliderABVround)% ABV."
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
