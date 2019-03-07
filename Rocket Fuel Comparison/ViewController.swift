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

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func calculateScore(energyByWeight w: Int, energyByVolume v: Int, price p: Int, ecologicalImpact e: Int) -> Int {
        return 5*w + 5*v - 10*p - 2*e //FIXME: This is total BS
    }
    private func updateScore(to newScore: Int) {
        score.stringValue = String(newScore)
        let red = NSColor(red: 1, green: 0, blue: 0, alpha: 1)
        let green = NSColor(red: 0, green: 1, blue: 0, alpha: 1)
        switch newScore {
        case let x where x < 9:
            score.textColor = red.blended(withFraction: 0, of: green)
        case let x where x < 18:
            score.textColor = red.blended(withFraction: 0.1, of: green)
        case let x where x < 27:
            score.textColor = red.blended(withFraction: 0.2, of: green)
        case let x where x < 36:
            score.textColor = red.blended(withFraction: 0.3, of: green)
        case let x where x < 45:
            score.textColor = red.blended(withFraction: 0.4, of: green)
        case let x where x < 54:
            score.textColor = red.blended(withFraction: 0.5, of: green)
        case let x where x < 63:
            score.textColor = red.blended(withFraction: 0.6, of: green)
        case let x where x < 72:
            score.textColor = red.blended(withFraction: 0.7, of: green)
        case let x where x < 81:
            score.textColor = red.blended(withFraction: 0.8, of: green)
        case let x where x < 90:
            score.textColor = red.blended(withFraction: 0.9, of: green)
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
extension NSColor {
    static func blend(color1: NSColor, intensity1: CGFloat = 0.5, color2: NSColor, intensity2: CGFloat = 0.5) -> NSColor {
        let total = intensity1 + intensity2
        let l1 = intensity1/total
        let l2 = intensity2/total
        guard l1 > 0 else { return color2 }
        guard l2 > 0 else { return color1 }
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return NSColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
    }
}
