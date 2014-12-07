//
//  CustomDrink.swift
//  DrinkCounter
//
//  Created by Andres Gonzalez on 12/4/14.
//  Copyright (c) 2014 Tiffany Lim. All rights reserved.
//

import UIKit

class CustomDrink: UIViewController {
    // initializes buttons and borders
    @IBOutlet weak var Submit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        sliderABV.value = 0.0
        sliderVolume.value = 0.0
        labelABV.text = "0 %"
        labelVolume.text = "0"
        
        borderMe(Submit)
    }
    
    var sliderVolumeround = Float()
    var sliderABVround = Float()
    
    @IBOutlet weak var sliderABV: UISlider!
    
    @IBOutlet weak var labelABV: UILabel!
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    @IBOutlet weak var labelVolume: UILabel!
    // initializs the slider for ABV and Volume and sets those values equal to variables
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
    // update alcohol count
    @IBAction func CustomDrinkPress(sender: AnyObject)
    {
        if (sliderVolumeround > 0 || sliderABVround > 0)
        {
            var alcoholConsumed: Float = sliderVolumeround * 28.3495231 * sliderABVround / 1400
        
            var message = "You have entered \(sliderVolumeround) ounces of a drink with \(sliderABVround)% ABV."
            alertMe("Success!", message)
        
            updateCount(alcoholConsumed)
        
            // Pop to root view controller ("counter" screen)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        // error checking
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
