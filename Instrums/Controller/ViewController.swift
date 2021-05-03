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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.3
        animation.toValue = 1
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        tapAnywhereLabel.layer.add(animation, forKey: nil)
    }
    
    @objc func startQuiz(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "startQuiz", sender: nil)
    }
    
    
}

