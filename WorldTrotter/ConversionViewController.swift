//
//  ConversionViewController.swift
//  WorldTrotter
//  An app that runs region specific temperature conversions and displays them on a randomly colored background background.
//  Created by Brigitte on 2/2/26
//  Updated on 2/24/26
//

import UIKit

class ConversionViewController: UIViewController {
    
    // RNG for new color
    func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }

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

    // Added color change function to viewWillAppear method for repeated change
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set new background
        view.backgroundColor = randomColor()
    }
}

