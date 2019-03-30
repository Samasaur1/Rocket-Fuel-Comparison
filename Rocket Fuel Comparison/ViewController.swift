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
        fuelChooser.addItems(withTitles: ["Solid", "Liquid"])
        
        sliderUpdated(0)
        
        self.view.window?.title = "Rocket Fuel Comparison"

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func calculateScore(energyByWeight w: Int, energyByVolume v: Int, price p: Int, ecologicalImpact e: Int) -> Int {
        let preadjustment = (5*w) + (5*v) - (9*p) - (1*e) + (0)
        let shift = preadjustment + 1000
        let shrink = Double(shift)/2
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
    @IBOutlet weak var energyByWeight: NSSlider!
    @IBOutlet weak var energyByVolume: NSSlider!
    @IBOutlet weak var price: NSSlider!
    @IBOutlet weak var ecologicalImpact: NSSlider!
    @IBOutlet weak var energyByWeightLabel: NSTextField!
    @IBOutlet weak var energyByVolumeLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    @IBOutlet weak var ecologicalImpactLabel: NSTextField!
    @IBAction func sliderUpdated(_ sender: Any) {
        let w = energyByWeight.integerValue
        let v = energyByVolume.integerValue
        let p = price.integerValue
        let e = ecologicalImpact.integerValue
        energyByWeightLabel.stringValue = String(w)
        energyByVolumeLabel.stringValue = String(v)
        priceLabel.stringValue = String(p)
        ecologicalImpactLabel.stringValue = String(e)
        updateScore(to: calculateScore(energyByWeight: w, energyByVolume: v, price: p, ecologicalImpact: e))
        fuelChooser.selectItem(at: -1) //deselects
    }
    @IBOutlet weak var score: NSTextField!
    @IBOutlet weak var fuelChooser: NSPopUpButton!
    @IBAction func fuelChosen(_ sender: NSPopUpButton) {
        update(to: try! Fuel(type: sender.titleOfSelectedItem ?? ""))
    }
    private func update(to fuel: Fuel) {
        energyByWeight.integerValue = fuel.w
        energyByVolume.integerValue = fuel.v
        price.integerValue = fuel.p
        ecologicalImpact.integerValue = fuel.e
        let i = fuelChooser.indexOfSelectedItem
        sliderUpdated(0)
        fuelChooser.selectItem(at: i)
    }
}

struct Fuel {
    let w: Int
    let v: Int
    let p: Int
    let e: Int
    init(energyByWeight: Int, energyByVolume: Int, price: Int, ecologicalImpact: Int) {
        w = energyByWeight
        v = energyByVolume
        p = price
        e = ecologicalImpact
    }
    //TODO:
    //FIXME:
    //MARK: - FUELS
    ///MUST BE BETWEEN 1 and 100
    static let solid = Fuel(energyByWeight: 1, energyByVolume: 2, price: 3, ecologicalImpact: 4)
    static let liquid = Fuel(energyByWeight: 5, energyByVolume: 6, price: 7, ecologicalImpact: 8)
    //MARK: -
    init(type: String) throws {
        switch type.lowercased() {
        case "solid":
            self = Fuel.solid
        case "liquid":
            self = Fuel.liquid
        default:
            throw InvalidFuelError()
        }
    }
    struct InvalidFuelError: Swift.Error {}
}
