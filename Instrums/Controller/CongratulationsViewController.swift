//
//  CongratulationsController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 29/04/21.
//

import UIKit

class CongratulationsViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    var color: UIColor = UIColor(red: 1.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Colors.setBackground(view: self.view)
        
        playAgainButton.layer.cornerRadius = 10
    }
    
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "navigateToQuiz", sender: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        performSegue(withIdentifier: "navigateToHome", sender: nil)
    }
    
}
