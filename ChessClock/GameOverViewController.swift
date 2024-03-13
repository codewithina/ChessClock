//
//  GameOverViewController.swift
//  ChessClock
//
//  Created by Ina Burström on 2024-03-13.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    var winningPlayer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        winnerLabel.text = winningPlayer
       
    }
}
