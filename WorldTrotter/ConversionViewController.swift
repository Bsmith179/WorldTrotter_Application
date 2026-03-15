//
//  ConversionViewController.swift
//  WorldTrotter
//  An app that runs region specific temperature conversions selectable by regions on a map.
//  Created by Brigitte on 2/2/26
//  Updated on 2/26/26
//  Updated on 3/15/26 to add Text Input and Delegation.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet var celsiusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ConversionViewController loaded its view.")


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
        
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = text
        } else {
            celsiusLabel.text = "???"
        }
    }

}

