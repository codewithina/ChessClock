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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var anotherGameButton: UIButton!
    
    let gameOverSegue = "gameOverSegue"
    
    var p1Timer: Timer?
    var p2Timer: Timer?
    var p1CurrentTime = 10
    var p2CurrentTime = 10
    var p1Moves = 0
    var p2Moves = 0
    var gameStarted = false
    var winner: String?
    var currentPlayer: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupTapRecognizers()
        setUpInitTimerArea()
    }
    
    func setupButtons(){
        if let symbolImage = UIImage(systemName: "play") {
            let scaledImage = symbolImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin))
            playButton.setImage(scaledImage, for: .normal)
        }
        
        if let symbolImage = UIImage(systemName: "pause") {
            let scaledImage = symbolImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin))
            pauseButton.setImage(scaledImage, for: .normal)
        }
        
        if let symbolImage = UIImage(systemName: "repeat") {
            let scaledImage = symbolImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin))
            anotherGameButton.setImage(scaledImage, for: .normal)
        }
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        if currentPlayer == 1{
            startP1Timer()
        } else if currentPlayer == 2 {
            startP2Timer()
        } else {return}
        
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        if gameStarted {
                   if let timer = p1Timer, timer.isValid {
                       pause(timer)
                       currentPlayer = 1
                   }
                   if let timer = p2Timer, timer.isValid {
                       pause(timer)
                       currentPlayer = 2
                   }
               }
    }
    
    @IBAction func newGameButtonAction(_ sender: UIButton) {
        resetGame()
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
                    pause(p1Timer)
                    startP2Timer()
                    addGreenBg(on: p2TimerArea)
                    p1Moves += 1
                    let p1NewText = "M O V E S :  \(p1Moves)"
                    p1MoveLabel.text = p1NewText
                }
            } else if sender.view == p2TimerArea {
                if p2Timer != nil && p2Timer!.isValid {
                    pause(p2Timer)
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
            updateLabel(p: 1)
            updateLabel(p: 2)
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
            gameEndCheck(by: p1CurrentTime, for: 1)
        }
    }
    
    func startP2Timer() {
        p2Timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.p2CurrentTime -= 1
            self.updateLabel(p: 2)
            gameEndCheck(by: p2CurrentTime, for: 2)
        }
    }
    
    func pause(_ timer: Timer?){
        timer?.invalidate()
    }
    
    func start(_ timer: Timer?){
        
    }
    
    func gameEndCheck(by currentTime: Int, for player: Int){
        if currentTime == 0 {
            pause(p2Timer)
            pause(p1Timer)
            
            if player == 1 {
                p1TimerArea.backgroundColor = UIColor(red: 199/255, green: 69/255, blue: 71/255, alpha: 1.0)
                winner = "Player 2 is the winner :)"
            }
            if player == 2 {
                p2TimerArea.backgroundColor = UIColor(red: 199/255, green: 69/255, blue: 71/255, alpha: 1.0)
                winner = "Player 1 is the winner :)"
            }
            
            performSegue(withIdentifier: gameOverSegue, sender: self)
        }
       
    }
    
    func resetGame(){
        if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
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
        timerArea.backgroundColor = UIColor(red: 123/255, green: 183/255, blue: 85/255, alpha: 1.0)
        
        if timerArea == p1TimerArea {
            p2TimerArea.backgroundColor = UIColor.systemGray4
        } else if timerArea == p2TimerArea {
            p1TimerArea.backgroundColor = UIColor.systemGray4
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == gameOverSegue {
            if let destinationVC = segue.destination as? GameOverViewController {
                destinationVC.winningPlayer = winner}
        }
    }
}
