//
//  ViewController.swift
//  Rocket Fuel Comparison
//
//  Created by Samasaur1 on 3/4/19.
//  Copyright © 2019 Samasaur1. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fuelChooser.removeAllItems()
        fuelChooser.addItems(withTitles: ["Liquid Oxygen + Liquid Hydrogen",
            "Liquid Oxygen + Liquid Methane", "Liquid Oxygen + Ethanol (25% Water)",
            "Liquid Oxygen + Kerosene", "Liquid Fluorine + Liquid Hydrogen",
            "FLOX-70 + Kerosene", "Nitrogen Tetroxide + Kerosene", "Hydrogen Peroxide + Kerosene",
            "Nitrous Oxide + HTPB", "Ammonium Perchlorate + Aluminum + HTPB"])
                                          
        
        sliderUpdated(0)
        
        self.view.window?.title = "Rocket Fuel Comparison"

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func calculateScore(thrust t: Int, specificImpulse s: Int, price p: Int) -> Int {
        let preadjustment = (4*t) + (6*s) - (5*p)
        let shift = preadjustment + 500
        let shrink = Double(shift)/3*2
        return Int(round(shrink))
    }
    private func updateScore(to newScore: Int) {
        score.stringValue = String(newScore)
        let red = NSColor(red: 1, green: 0, blue: 0, alpha: 1)
        let green = NSColor(red: 0, green: 1, blue: 0, alpha: 1)
        switch newScore {
        case let x where x < 45:
            score.textColor = red.blended(withFraction: 0, of: green)
        case let x where x < 90:
            score.textColor = red.blended(withFraction: 0.05, of: green)
        case let x where x < 135:
            score.textColor = red.blended(withFraction: 0.1, of: green)
        case let x where x < 180:
            score.textColor = red.blended(withFraction: 0.15, of: green)
        case let x where x < 225:
            score.textColor = red.blended(withFraction: 0.2, of: green)
        case let x where x < 270:
            score.textColor = red.blended(withFraction: 0.25, of: green)
        case let x where x < 315:
            score.textColor = red.blended(withFraction: 0.3, of: green)
        case let x where x < 360:
            score.textColor = red.blended(withFraction: 0.35, of: green)
        case let x where x < 405:
            score.textColor = red.blended(withFraction: 0.4, of: green)
        case let x where x < 450:
            score.textColor = red.blended(withFraction: 0.45, of: green)
        case let x where x < 495:
            score.textColor = red.blended(withFraction: 0.5, of: green)
        case let x where x < 540:
            score.textColor = red.blended(withFraction: 0.55, of: green)
        case let x where x < 585:
            score.textColor = red.blended(withFraction: 0.6, of: green)
        case let x where x < 630:
            score.textColor = red.blended(withFraction: 0.65, of: green)
        case let x where x < 675:
            score.textColor = red.blended(withFraction: 0.7, of: green)
        case let x where x < 720:
            score.textColor = red.blended(withFraction: 0.75, of: green)
        case let x where x < 765:
            score.textColor = red.blended(withFraction: 0.8, of: green)
        case let x where x < 810:
            score.textColor = red.blended(withFraction: 0.85, of: green)
        case let x where x < 855:
            score.textColor = red.blended(withFraction: 0.9, of: green)
        case let x where x < 900:
            score.textColor = red.blended(withFraction: 0.925, of: green)
        case let x where x < 933:
            score.textColor = red.blended(withFraction: 0.95, of: green)
        case let x where x < 966:
            score.textColor = red.blended(withFraction: 0.975, of: green)
        default:
            score.textColor = red.blended(withFraction: 1, of: green)
        }
    }
    @IBOutlet weak var thrust: NSSlider!
    @IBOutlet weak var specificImpulse: NSSlider!
    @IBOutlet weak var price: NSSlider!
    @IBOutlet weak var thrustLabel: NSTextField!
    @IBOutlet weak var specificImpulseLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    @IBAction func sliderUpdated(_ sender: Any) {
        let t = thrust.integerValue
        let s = specificImpulse.integerValue
        let p = price.integerValue
        thrustLabel.stringValue = String(t)
        specificImpulseLabel.stringValue = String(s)
        priceLabel.stringValue = String(p)
        updateScore(to: calculateScore(thrust: t, specificImpulse: s, price: p))
        fuelChooser.selectItem(at: -1) //deselects
    }
    @IBOutlet weak var score: NSTextField!
    @IBOutlet weak var fuelChooser: NSPopUpButton!
    @IBAction func fuelChosen(_ sender: NSPopUpButton) {
        update(to: try! Fuel(type: sender.titleOfSelectedItem ?? ""))
    }
    private func update(to fuel: Fuel) {
        thrust.integerValue = fuel.t
        specificImpulse.integerValue = fuel.s
        price.integerValue = fuel.p
        let i = fuelChooser.indexOfSelectedItem
        sliderUpdated(0)
        fuelChooser.selectItem(at: i)
    }
}

struct Fuel {
    let t: Int
    let s: Int
    let p: Int
    
    /// Create a Fuel
    ///
    /// - Parameters:
    ///   - specificImpulse: The specific impulse of the fuel, in seconds.
    ///   - price: The price of the fuel, in USD/kilogram ($/kg)
    init(specificImpulse: Int, price: Int) {
        t = Int(round(Double(specificImpulse)/5)) + Int.random(in: -1...1) //so that they aren't always the same
        s = Int(round(Double(specificImpulse)/5))// /500*100
        p = Int(round(Double(price)/15))// /1500*100
    }
    //TODO:
    //FIXME:
    //MARK: - FUELS
    ///MUST BE BETWEEN 1 and 100
    //not anymore 3/30/19-5:52PM — scaled in constructor
    static let LoxLhydrogen = Fuel(specificImpulse: 381, price: 308)
    static let LoxLmethane = Fuel(specificImpulse: 299, price: 103)
    static let LoxAlcohol = Fuel(specificImpulse: 269, price: 61)
    static let LoxKerosene = Fuel(specificImpulse: 289, price: 849)
    static let LfLhydrogen = Fuel(specificImpulse: 400, price: 399)
    static let fLoxKerosene = Fuel(specificImpulse: 320, price: 1050)
    static let NTOKerosene = Fuel(specificImpulse: 267, price: 1077)
    static let HperKerosene = Fuel(specificImpulse: 258, price: 1086)
    static let NOHTPB = Fuel(specificImpulse: 248, price: 883)
    static let AmmPClAlHTPB = Fuel(specificImpulse: 277, price: 71)
    //MARK: -
    init(type: String) throws {
        switch type {
        case "Liquid Oxygen + Liquid Hydrogen":
            self = Fuel.LoxLhydrogen
        case "Liquid Oxygen + Liquid Methane":
            self = Fuel.LoxLmethane
        case "Liquid Oxygen + Ethanol (25% Water)":
            self = Fuel.LoxAlcohol
        case "Liquid Oxygen + Kerosene":
            self = Fuel.LoxKerosene
        case "Liquid Fluorine + Liquid Hydrogen":
            self = Fuel.LfLhydrogen
        case "FLOX-70 + Kerosene":
            self = Fuel.fLoxKerosene
        case "Nitrogen Tetroxide + Kerosene":
            self = Fuel.NTOKerosene
        case "Hydrogen Peroxide + Kerosene":
            self = Fuel.HperKerosene
        case "Nitrous Oxide + HTPB":
            self = Fuel.NOHTPB
        case "Ammonium Perchlorate + Aluminum + HTPB":
            self = Fuel.AmmPClAlHTPB
        default:
            throw InvalidFuelError()
        }
    }
    struct InvalidFuelError: Swift.Error {}
}
