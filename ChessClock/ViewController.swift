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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        p1Timer.backgroundColor = UIColor.lightGray
    }
    
}

