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
    
    var p1Timer: Timer?
    var p2Timer: Timer?
    var p1CurrentTime = 600
    var p2CurrentTime = 600
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
           if !gameStarted {
               gameStarted = true
               startP1Timer()
           } else {
               if sender.view == p1TimerArea {
                       if p1Timer != nil && p1Timer!.isValid {
                           p1Timer?.invalidate() // Stoppa p1Timer om den är aktiv
                           startP2Timer() // Starta p2Timer
                       }
                   } else if sender.view == p2TimerArea {
                       if p2Timer != nil && p2Timer!.isValid {
                           p2Timer?.invalidate() // Stoppa p2Timer om den är aktiv
                           startP1Timer() // Starta p1Timer
                       }
                   }
           }
       }
    
    
    func setUpInitTimerArea(){
        p1TimerArea.layer.cornerRadius = 20
        p1TimeLabel.text = "10:00"
        p1TimeLabel.font = UIFont(name: "Arial", size: 60)
        p2TimerArea.layer.cornerRadius = 20
        p2TimeLabel.text = "10:00"
        p2TimeLabel.font = UIFont(name: "Arial", size: 60)
        p2TimeLabel.transform = CGAffineTransform(rotationAngle: .pi)
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
    
    func onGoingTimerBg(timerArea: UIView) {
        timerArea.backgroundColor = UIColor.green
    }
    
}

//Hantera Touch Events med UITapGestureRecognizer: Du behöver lägga till en UITapGestureRecognizer till varje UIView. När en spelare trycker på sin klocka, ska du stoppa deras timer och starta motståndarens timer.
//
//Uppdatera UILabels med aktuell tid: När en timer tickar, uppdatera motsvarande UILabel med aktuell tid.
//
//Hantera spelets slut: När en spelares tid är slut, stanna båda timers och visa en alert som meddelar vem som vann.
//
