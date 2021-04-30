//
//  ViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 27/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tapAnywhereLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Colors.setBackground(view: self.view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.startQuiz(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func startQuiz(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "startQuiz", sender: nil)
    }
    
    
}

