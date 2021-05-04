//
//  Quiz.swift
//  Instrums
//
//  Created by Stefan Adisurya on 28/04/21.
//

import UIKit
import AVFoundation
import CoreData

class QuizViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var instrumentButton: UIButton!
    
    var instrumentNames = [String]()
    var instrumentFacts = [String]()
    
    var instruments: [Instruments] = [].shuffled()
    var correctAnswer = Int.random(in: 0 ... 2)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tag: Int = 0
    var score: Int = 0
    var currentSong: String = ""
    
    var imageName: String = ""
    var isFinished: Bool = false
    var isFlipped: Bool = false
    
    var color: UIColor = UIColor(red: 1.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    
    var song: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instrumentNames = InstrumentRepository.generateInstrumentNames()
        instrumentFacts = InstrumentRepository.generateInstrumentFacts()
        
        Colors.setBackground(view: self.view)
        
        generateInstruments()
        fetchInstruments()
        
        self.tag = 0
        setUpButton()
    }
    
    func createInstrument(name: String, fact: String) {
        let instrument = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
        instrument.name = name
        instrument.fact = fact
    }
    
    func generateInstruments() {
        for i in 0..<instrumentNames.count {
            createInstrument(name: instrumentNames[i], fact: instrumentFacts[i])
        }

        do {
            try self.context.save()
        } catch {

        }
    }
    
    func deleteData() {
        let deleteAll = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Instruments"))
        
        do {
            try context.execute(deleteAll)
        }
        catch {
            print(error)
        }
    }
    
    func fetchInstruments() {
        do {
            let request = Instruments.fetchRequest() as NSFetchRequest<Instruments>
            
            self.instruments = try context.fetch(request)
        } catch {
            
        }
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
            answerButton.setTitle("\((instruments[i].name)!)", for: .normal)
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
            
            imageName = "\((instruments[self.correctAnswer].name)!)"
            instrumentButton.setImage(UIImage(named: imageName), for: .normal)
            
            self.currentSong = "\((instruments[self.correctAnswer].name)!)"
            
            answerButton.addTarget(self, action: #selector(self.checkAnswer(sender:)), for: .touchUpInside)
            
            self.view.addSubview(answerButton)
        }
    }
    
    @objc func checkAnswer(sender: UIButton!) {
        var alertTitle = ""
        var alertMessage = ""
        var flippedMessage = ""
        
        stopInstrument()
        isFlipped = true
        
        if sender.titleLabel?.text == self.imageName {
            self.score += 1
            alertTitle = "Correct!"
            alertMessage = "\((instruments[self.correctAnswer].fact)!)"
            flippedMessage = "✅"
            self.currentSong = "Correct"
        } else {
            self.score += 0
            alertTitle = "Oops!"
            alertMessage = "It's a \((self.instruments[self.correctAnswer].name)!)"
            flippedMessage = "❌"
            self.currentSong = "Wrong"
        }
        
        self.playInstrument()
        
        if isFlipped {
            isFlipped = false
            sender.setTitle(flippedMessage, for: .normal)
            UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            isFlipped = true
            sender.setTitle("", for: .normal)
            UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
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
        
        if self.score == 1 {
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
        self.instruments.removeAll()
        self.deleteData()
        self.instruments.shuffle()
        self.stopInstrument()
        self.correctAnswer = Int.random(in: 0 ... 2)
        self.viewDidLoad()
    }
    
    @IBAction func howToPlay(_ sender: Any) {
        self.stopInstrument()
        performSegue(withIdentifier: "howToPlay", sender: nil)
    }
    
    @IBAction func quitQuiz(_ sender: Any) {
        self.stopInstrument()
        
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
