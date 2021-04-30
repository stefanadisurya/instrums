//
//  Quiz.swift
//  Instrums
//
//  Created by Stefan Adisurya on 28/04/21.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var instrumentButton: UIButton!
    
    var instruments: [String] = ["Accordion", "Banjo", "Bass", "Bongo", "Cowbell", "Drum", "Fork", "Guitar", "Harp", "Horn", "Keyboard", "Panpipe", "Saxophone", "Trumpet", "Violin"].shuffled()
    var correctAnswer = Int.random(in: 0 ... 2)
    
    var tag: Int = 0
    var score: Int = 0
    var currentSong: String = ""
    
    var imageName: String = ""
    var isFinished: Bool = false
    
    var color: UIColor = UIColor(red: 1.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    
    var song: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Colors.setBackground(view: self.view)
        
        self.tag = 0
        setUpButton()
    }
    
    @IBAction func playInstrument() {
        let path = Bundle.main.path(forResource: "\(self.currentSong).mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            song = try AVAudioPlayer(contentsOf: url)
            song?.play()
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    func stopInstrument() {
        let path = Bundle.main.path(forResource: "\(self.currentSong).mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            song = try AVAudioPlayer(contentsOf: url)
            song?.stop()
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    func setUpButton() {
        var buttonX: CGFloat = 16
        
        for i in 0 ..< 3 {
            let answerButton = UIButton(frame: CGRect(x: buttonX, y: 705, width: 114, height: 114))
            buttonX += 120
            
            answerButton.layer.cornerRadius = 10
            answerButton.backgroundColor = .white
            answerButton.setTitle("\(instruments[i])", for: .normal)
            answerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            
            if self.tag == 0 {
                answerButton.setTitleColor(self.color, for: .normal)
            } else if self.tag == 1 {
                answerButton.setTitleColor(.systemOrange, for: .normal)
            } else {
                answerButton.setTitleColor(.systemRed, for: .normal)
            }
            
            answerButton.tag = tag
            self.tag += 1
            
            imageName = "\(instruments[self.correctAnswer])"
            instrumentButton.setImage(UIImage(named: imageName), for: .normal)
            
            self.currentSong = "\(instruments[self.correctAnswer])"
            
            answerButton.addTarget(self, action: #selector(self.checkAnswer(sender:)), for: .touchUpInside)
            
            self.view.addSubview(answerButton)
        }
    }
    
    @objc func checkAnswer(sender: UIButton!) {
        var alertTitle = ""
        var alertMessage = ""
        
        stopInstrument()
        
        if sender.titleLabel?.text == self.imageName {
            self.score += 1
            alertTitle = "Correct!"
            alertMessage = "Nice"
        } else {
            self.score += 0
            alertTitle = "Oops!"
            alertMessage = "It's a \(self.instruments[correctAnswer])"
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let continueButton = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.nextQuestion()
        }
        
        let alert2 = UIAlertController(title: "Well done!", message: "You finished the quiz 🔥", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.isFinished = true
            self.performSegue(withIdentifier: "navigateToCongratulations", sender: nil)
        }
        
        if self.score == 10 {
            alert2.addAction(okButton)
            self.present(alert2, animated: true, completion: nil)
            self.score = 0
        } else {
            alert.addAction(continueButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    func nextQuestion() {
        self.instruments.shuffle()
        self.correctAnswer = Int.random(in: 0 ... 2)
        self.viewDidLoad()
    }
    
    @IBAction func howToPlay(_ sender: Any) {
        performSegue(withIdentifier: "howToPlay", sender: nil)
    }
    
    @IBAction func quitQuiz(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Any progress will be lost", preferredStyle: .alert)
        
        let quitButton = UIAlertAction(title: "Quit", style: .default) { (action) in
            self.performSegue(withIdentifier: "quitQuiz", sender: nil)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(quitButton)
        alert.addAction(cancelButton)
        alert.preferredAction = quitButton
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
