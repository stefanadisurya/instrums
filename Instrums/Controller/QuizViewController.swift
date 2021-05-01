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
        
        Colors.setBackground(view: self.view)
        
        generateInstruments()
        fetchInstruments()
        
        self.tag = 0
        setUpButton()
    }
    
    func generateInstruments() {
            let instrument1 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument1.name = "Accordion"
            instrument1.fact = "In 🇩🇪, 'Akkord' means 'musical chord, concord of sounds'."

            let instrument2 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument2.name = "Banjo"
            instrument2.fact = "Banjo was invented by West Africans 🧑🏿‍🦱"

            let instrument3 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument3.name = "Bass"
            instrument3.fact = "Bass is the key to a solid 'music ground' 💪"

            let instrument4 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument4.name = "Bongo"
            instrument4.fact = "Bongo always come as a pair 👫"

            let instrument5 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument5.name = "Cowbell"
            instrument5.fact = "Cowbell is mainly used in Latin music 💃🏽"

            let instrument6 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument6.name = "Drum"
            instrument6.fact = "The oldest drum to be discovered is the Alligator Drum 🥁"

            let instrument7 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument7.name = "Fork"
            instrument7.fact = "John Shore invented tuning fork in 1752 🍴"

            let instrument8 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument8.name = "Guitar"
            instrument8.fact = "The shortest guitar is just 10 microns 🎸"

            let instrument9 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument9.name = "Harp"
            instrument9.fact = "Harp is believed to have existed since 15,000 BC 🦖"

            let instrument10 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument10.name = "Horn"
            instrument10.fact = "It was used especially by postilions of the 18th and 19th centuries 👨🏻‍✈️"

            let instrument11 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument11.name = "Keyboard"
            instrument11.fact = "Keyboard is capable on producing a vairty of sounds 🎹"

            let instrument12 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument12.name = "Panpipe"
            instrument12.fact = "Panpipe is also called syrinx 😲"

            let instrument13 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument13.name = "Saxophone"
            instrument13.fact = "The standard saxophone has 23 keys 🎶"

            let instrument14 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument14.name = "Trumpet"
            instrument14.fact = "Trumpet are actually 3500 years old 👴🏻"

            let instrument15 = NSEntityDescription.insertNewObject(forEntityName: "Instruments", into: context) as! Instruments
            instrument15.name = "Violin"
            instrument15.fact = "Playing the violin burns approximately 170 calories per hour 🏋🏻‍♂️"

            do {
                try self.context.save()
            } catch {

            }
        }
    
    func deleteData() {
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Instruments"))
        
        do {
            try context.execute(DelAllReqVar)
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
        } else {
            self.score += 0
            alertTitle = "Oops!"
            alertMessage = "It's a \((self.instruments[self.correctAnswer].name)!)"
            flippedMessage = "❌"
        }
        
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
        self.instruments.removeAll()
        self.deleteData()
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
