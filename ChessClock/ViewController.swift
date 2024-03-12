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
    var p1CurrentTime = 0
    var p2CurrentTime = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpInitTimerArea()
       
    }
    
    func setUpInitTimerArea(){
        p1TimeLabel.text = "10:00"
        p1TimeLabel.font = UIFont(name: "Arial", size: 60)
        p2TimeLabel.text = "10:00"
        p2TimeLabel.font = UIFont(name: "Arial", size: 60)
        p2TimeLabel.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func onGoingTimerBg(timerArea: UIView) {
        timerArea.backgroundColor = UIColor.green
    }
    
}

//Skapa en Timer för varje klocka: Du kommer att behöva en timer för att hålla koll på tiden för varje spelare. Har du jobbat med Timer i Swift tidigare?
//
//Hantera Touch Events med UITapGestureRecognizer: Du behöver lägga till en UITapGestureRecognizer till varje UIView. När en spelare trycker på sin klocka, ska du stoppa deras timer och starta motståndarens timer.
//
//Uppdatera UILabels med aktuell tid: När en timer tickar, uppdatera motsvarande UILabel med aktuell tid.
//
//Hantera spelets slut: När en spelares tid är slut, stanna båda timers och visa en alert som meddelar vem som vann.
//
