//
//  ViewController.swift
//  ChessClock
//
//  Created by Ina Burström on 2024-03-11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var p1TimerArea: UIView!
    @IBOutlet weak var p2TimerArea: UIView!
    
    @IBOutlet weak var p1TimeLabel: UILabel!
    @IBOutlet weak var p2TimeLabel: UILabel!
    
    @IBOutlet weak var p1MoveLabel: UILabel!
    @IBOutlet weak var p2MoveLabel: UILabel!
    
    var p1Timer: Timer?
    var p2Timer: Timer?
    var p1CurrentTime = 600
    var p2CurrentTime = 600
    var p1Moves = 0
    var p2Moves = 0
    var gameStarted = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapRecognizers()
        setUpInitTimerArea()
    }
    
    func setupTapRecognizers(){
        let p1TapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        p1TimerArea.addGestureRecognizer(p1TapGesture)
        let p2TapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        p2TimerArea.addGestureRecognizer(p2TapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else {return}
        if !gameStarted {
            gameStarted = true
            addGreenBg(on: tappedView)
            if tappedView == p1TimerArea {
                startP1Timer()
            } else if tappedView == p2TimerArea {
                startP2Timer()
            }
        } else {
            if sender.view == p1TimerArea {
                if p1Timer != nil && p1Timer!.isValid {
                    p1Timer?.invalidate()
                    startP2Timer()
                    addGreenBg(on: p2TimerArea)
                    p1Moves += 1
                    let p1NewText = "M O V E S :  \(p1Moves)"
                    p1MoveLabel.text = p1NewText
                }
            } else if sender.view == p2TimerArea {
                if p2Timer != nil && p2Timer!.isValid {
                    p2Timer?.invalidate()
                    startP1Timer()
                    addGreenBg(on: p1TimerArea)
                    p2Moves += 1
                    let p2NewText = "M O V E S : \(p2Moves)"
                    p2MoveLabel.text = p2NewText
                }
            }
        }
    }
    
    
    func setUpInitTimerArea(){
        let playerArea: [UIView] = [p1TimerArea, p2TimerArea]
        let playerTimerLabels: [UILabel] = [p1TimeLabel, p2TimeLabel]
        
        applyTextAndFont(to: playerTimerLabels)
        applyRoundedCornerAndShadow(to: playerArea)
        self.p2TimerArea.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func applyTextAndFont(to timerLabels: [UILabel]) {
        for label in timerLabels {
            label.text = "10:00"
            label.font = UIFont(name: "Arial", size: 60)
        }
    }
    
    func applyRoundedCornerAndShadow(to views: [UIView]) {
        for view in views {
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 4
            view.layer.masksToBounds = false
        }
    }
    
    func startP1Timer() {
        p1Timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.p1CurrentTime -= 1
            self.updateLabel(p: 1)
        }
    }
    
    func startP2Timer() {
        p2Timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.p2CurrentTime -= 1
            self.updateLabel(p: 2)
        }
    }
    
    func updateLabel(p player: Int) {
        var currentTime: Int = 0
        if player == 1 {
            currentTime = p1CurrentTime
        } else if player == 2 {
            currentTime = p2CurrentTime
        }
        
        let minutes = currentTime / 60
        let seconds = currentTime % 60
        
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        
        if player == 1 {
            p1TimeLabel.text = timeString
        } else if player == 2 {
            p2TimeLabel.text = timeString
        }
    }
    
    func addGreenBg(on timerArea: UIView) {
        timerArea.backgroundColor = UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 0.6)
        
        if timerArea == p1TimerArea {
            p2TimerArea.backgroundColor = UIColor.systemGray4
        } else if timerArea == p2TimerArea {
            p1TimerArea.backgroundColor = UIColor.systemGray4
        }
    }
}

