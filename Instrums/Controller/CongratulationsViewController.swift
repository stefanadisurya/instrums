//
//  CongratulationsController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 29/04/21.
//

import UIKit
import AVFoundation

class CongratulationsViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    var song: AVAudioPlayer?
    var currentSong: String = ""
    
    var color: UIColor = UIColor(red: 1.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentSong = "Congratulations"
        
        Colors.setBackground(view: self.view)
        
        self.playInstrument()
        
        playAgainButton.layer.cornerRadius = 10
        playAgainButton.setTitleColor(self.color, for: .normal)
    }
    
    @IBAction func playInstrument() {
        let path = Bundle.main.path(forResource: "\(self.currentSong).mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            song = try AVAudioPlayer(contentsOf: url)
            song?.delegate = self
            song?.play()
            song?.setVolume(0, fadeDuration: 15)
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playInstrument()
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
    
    @IBAction func playAgain(_ sender: Any) {
        self.stopInstrument()
        performSegue(withIdentifier: "navigateToQuiz", sender: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.stopInstrument()
        performSegue(withIdentifier: "navigateToHome", sender: nil)
    }
    
}
