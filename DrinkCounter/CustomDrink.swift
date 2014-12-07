//
//  CustomDrink.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class CustomDrink: UIViewController {
    
    /*
    *  Initializes buttons and borders
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderABV.value = 0.0
        sliderVolume.value = 0.0
        labelABV.text = "0 %"
        labelVolume.text = "0"
        
        borderMe(Submit)
    }
    
    // Defines sliders as Floats
    var sliderVolumeround = Float()
    var sliderABVround = Float()
    
    // Defines label, slider, and button outlets
    @IBOutlet weak var Submit: UIButton!
    
    @IBOutlet weak var sliderABV: UISlider!
    
    @IBOutlet weak var labelABV: UILabel!
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    @IBOutlet weak var labelVolume: UILabel!
    
    
    /*
    *  Initializs the slider for ABV and sets those values equal to variables
    */
        @IBAction func changeABV(sender: AnyObject)
    {
        sliderABVround = round(10 * sliderABV.value) / 10
        labelABV.text = "\(sliderABVround) %"
    }


    /*
    *  Initializs the slider for Volume and sets those values equal to variables
    */
    @IBAction func changeVolume(sender: AnyObject)
    {
        sliderVolumeround = round(10 * sliderVolume.value) / 10
        labelVolume.text = "\(sliderVolumeround)"
    }
    
    /*
    *  Update alcohol count
    */
    @IBAction func CustomDrinkPress(sender: AnyObject)
    {
        // Only accept if both volume and ABV are positive numbers
        if (sliderVolumeround > 0 || sliderABVround > 0)
        {
            // Alerts user of their input
            var message = "You have entered \(sliderVolumeround) ounces of a drink with \(sliderABVround)% ABV."
            alertMe("Success!", message)
            
            // Updates drink count with amount of alcohol consumed
            var alcoholConsumed: Float = sliderVolumeround * 28.3495231 * sliderABVround / 1400
            updateCount(alcoholConsumed)
        
            // Pop to root view controller ("counter" screen)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        else
        {
            alertMe("Error", "Volume and ABV must be set to positive values")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
