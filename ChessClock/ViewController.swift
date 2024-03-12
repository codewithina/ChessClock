//
//  ViewController.swift
//  ChessClock
//
//  Created by Ina Burström on 2024-03-11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var p1Timer: UIView!
    @IBOutlet weak var p2Timer: UIView!
    
    @IBOutlet weak var p1TimeLabel: UILabel!
    @IBOutlet weak var p2TimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        p1Timer.backgroundColor = UIColor.blue
        p2Timer.backgroundColor = UIColor.blue
        print("Hello")
    }
    
}

