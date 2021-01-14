//
//  ViewController.swift
//  AimForThat
//
//  Created by Sergio Carralero Nuño on 08/11/2020.
//

import UIKit

class ViewController: UIViewController {

    var currentValue : Int = 0
    var targetValue : Int = 0
    var score : Int = 0
    var round : Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        resetGame()
        updateLabels()
    }
    
    func setupSlider() {
        let thumbImageNormal = UIImage.init(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage.init(named: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage.init(named: "SliderTrackLeft")
        let trackRightImage = UIImage.init(named: "SliderTrackRight")
        
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    @IBAction func showAlertButton() {
        
        let difference : Int = abs(self.currentValue - self.targetValue)
        
        var points = 100 - difference
        
        let title : String
        
        switch difference {
        case 0:
            title = "Perfect Score!"
            points = Int(10.0 * Float(points))
        case 1...5:
            title = "Almost Perfect!"
            points = Int(1.5 * Float(points))
        case 6...12:
            title = "You have fallen short!"
            points = Int(1.2 * Float(points))
        default:
            title = "You've gone far away"
        }
        
        self.score += points
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler:
                                    { action in
                                        self.startNewRound()
                                        self.updateLabels()
                                    })
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
    }
    
    func startNewRound() {
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 1
        self.slider.value = Float(self.currentValue)
        self.round += 1
    }
    
    func updateLabels() {
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
    
    @IBAction func startNewGame() {
        resetGame()
        updateLabels()
    }
    
    func resetGame() {
        self.score = 0
        self.round = 0
        self.startNewRound()
    }
    
}

