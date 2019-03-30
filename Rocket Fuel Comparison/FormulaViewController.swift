//
//  FormulaViewController.swift
//  Rocket Fuel Comparison
//
//  Created by Samasaur1 on 3/29/19.
//  Copyright © 2019 Samasaur1. All rights reserved.
//

import Cocoa

class FormulaViewController: NSViewController {
    override func viewDidLoad() {
        explanationLabel.stringValue = "Given t is the thrust of a fuel, s is the specific impulse, p is the price, and e is the ecological impact, the following formula is used to calculate score:"
    }
    @IBOutlet weak var explanationLabel: NSTextField!
}
