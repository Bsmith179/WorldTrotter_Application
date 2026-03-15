//
//  ConversionViewController.swift
//  WorldTrotter
//  An app that runs region specific temperature conversions selectable by regions on a map.
//  Created by Brigitte on 2/2/26
//  Updated on 2/26/26
//  Updated on 3/15/26 to add Text Input and Delegation.
//  Updated on 3/15/26 to complete "Lab 6 Bronze Challenge - Character Validation".
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        textField.delegate = self

        updateCelsiusLabel()
        
        // let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        // let firstView = UIView(frame: firstFrame)
        // firstView.backgroundColor = UIColor.blue
        // view.addSubview(firstView)
        
        // let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
        // let secondView = UIView(frame: secondFrame)
        // secondView.backgroundColor = UIColor.green
        // firstView.addSubview(secondView)
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text =
            numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        // Create Acceptable Character Set And Reject Invalid Entries
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789\(decimalSeparator)")
        let notAllowedCharacterSet = allowedCharacterSet.inverted
        
        if string.rangeOfCharacter(from: notAllowedCharacterSet) != nil {
            return false
        }

        let existingTextHasDecimalSeparator
                = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
}
