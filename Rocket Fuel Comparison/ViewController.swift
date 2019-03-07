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
        score.stringValue = String(calculateScore(energyByWeight: w, energyByVolume: v, price: p, ecologicalImpact: e))
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
