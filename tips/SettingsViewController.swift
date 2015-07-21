//
//  SettingsViewController.swift
//  tips
//
//  Created by Xian on 7/20/15.
//  Copyright (c) 2015 swifterlabs. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var savedPercentageSlider: UILabel!
    
    @IBOutlet weak var keyboardDefaultSwitch: UISwitch!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentage = defaults.floatForKey("tipPercentage")
        
        var keyboardDefault = defaults.boolForKey("keyboardDefault")
        
        // set tip percentage default default
        if tipPercentage == 0 {
            tipPercentage = 20;
        }
        
        tipPercentageSlider.value = tipPercentage
        updateTipPercentageSuccessString()
        
        keyboardDefaultSwitch.setOn(keyboardDefault, animated:false)
        
    }
    
    
    @IBAction func closeAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func updateTipPercentageSuccessString() {
        savedPercentageSlider.text = "Successfully saved as " + String(format: "%.0f", tipPercentageSlider.value) + "%"
    }
    
    @IBAction func onTipPercentageValueChanged(sender: AnyObject) {

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(tipPercentageSlider.value, forKey: "tipPercentage")
        defaults.synchronize()
        
        updateTipPercentageSuccessString()
        
    }
    
    @IBAction func onKeyboardDefaultValueChanged(sender: AnyObject) {

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(keyboardDefaultSwitch.on, forKey: "keyboardDefault")
        defaults.synchronize()
        
    }
}
