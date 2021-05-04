//
//  ViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 27/04/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var song: AVAudioPlayer?
    var currentSong: String = ""
    
    @IBOutlet weak var tapAnywhereLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentSong = "Background"
        
        Colors.setBackground(view: self.view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.startQuiz(_:)))
        self.view.addGestureRecognizer(tap)
        playInstrument()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.3
        animation.duration = 1.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        tapAnywhereLabel.layer.add(animation, forKey: nil)
    }
    
    @objc func startQuiz(_ sender: UITapGestureRecognizer? = nil) {
        self.stopInstrument()
        performSegue(withIdentifier: "startQuiz", sender: nil)
    }
    
    @IBAction func playInstrument() {
        let path = Bundle.main.path(forResource: "\(self.currentSong).mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            song = try AVAudioPlayer(contentsOf: url)
            song?.delegate = self
            song?.play()
            song?.setVolume(0, fadeDuration: 27)
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playInstrument()
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
    
}

