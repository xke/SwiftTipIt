//
//  ViewController.swift
//  tips
//
//  Created by Xian on 7/20/15.
//  Copyright (c) 2015 swifterlabs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!

    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var billTotal: Float = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        splitStepper.value = 2
        updateSplitText()
        

        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // grab default percentage
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentage = defaults.floatForKey("tipPercentage")
        
        if tipPercentage == 0 {
            tipPercentage = 20;
        }
        
        tipPercentageSlider.value = tipPercentage


        updateTipFields()
        
        // autofocus on bill, if set
        
        var keyboardDefault = defaults.boolForKey("keyboardDefault")
        
        if keyboardDefault {
            self.billField.becomeFirstResponder()
        }
        
    }
    
    
    @IBAction func onBillEditingChanged(sender: AnyObject) {
        updateTipFields()
    }
    

    @IBAction func onPercentageSliderValueChanged(sender: AnyObject) {
        updateTipFields()
    }

    
    @IBAction func onSplitStepperValueChanged(sender: AnyObject) {
        
        updateSplitText()
        
        var split = billTotal / Float(splitStepper.value)
        splitNumberLabel.text = String(format: "$%.2f", split)

    }

    
    func updateTipFields() {
        
        var tipPercentageDisplayed = String(format: "%.0f", tipPercentageSlider.value)
        tipPercentageLabel.text = "Tip (" + tipPercentageDisplayed + "%)"
        
        var billAmount = (billField.text as NSString).floatValue
        // make sure to use the integer / displayed value to do tip calculation
        var tip = billAmount * (tipPercentageDisplayed as NSString).floatValue / 100
        
        billTotal = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", billTotal)
        
        var split = billTotal / Float(splitStepper.value)
        splitNumberLabel.text = String(format: "$%.2f", split)
        
    }
    
    func updateSplitText() {
        splitLabel.text = "Split (by \(Int(splitStepper.value)))"
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

