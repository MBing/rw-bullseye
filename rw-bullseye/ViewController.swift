//
//  ViewController.swift
//  rw-bullseye
//
//  Created by Martin Demiddel on 28.10.18.
//  Copyright © 2018 Martin Bing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var randomNumber: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var roundNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentValue = Int(slider.value)
        self.startNewRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftTrackImage = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftTrackImage, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightTrackImage = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightTrackImage, for: .normal)
        
    }
    func startNewRound() {
        self.targetValue = Int.random(in: 1...100)
        self.currentValue = 50
        slider.value = Float(self.currentValue)
        self.updateLabels()
    }
    
    func updateLabels() {
        self.randomNumber.text = String(self.targetValue)
        self.finalScore.text = String(self.score)
        self.roundNumber.text = String(self.round)
    }
    
    @IBAction func startOVer(_ sender: Any) {
        self.resetValues()
    }
    
    func resetValues() {
        self.score = 0
        self.round = 0
        self.startNewRound()
    }

    @IBAction func showAlert() {
        let diff = getDifference(target: self.targetValue, slider: self.currentValue)
        self.score += 100 - diff
        self.round += 1
        
        var message = "You selected: \(self.currentValue) \n"
        var title = "Selected Value"
        
        switch diff {
        case 0:
            message = "Congrats You Got it!!"
            title = "Winner!!!"
            self.score += 100
        case 1...10:
            message += "Very close but not enough"
            if diff == 1 {
                self.score += 50
            }
        case 10...30:
            message += "Not close enough!"
        case 30...50:
            message += "Get some glasses!"
        default:
            message += "This is embarrassing far off.."
        }
        
        message += "\nYou scored \(self.score)!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
        action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func getDifference(target: Int, slider: Int) -> Int {
        return abs(target - slider)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = Int(sender.value)
    }
}

