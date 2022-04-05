//
//  ViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 27/04/21.
//

import AVFoundation
import AsyncDisplayKit

/* User Interface */
class ViewController: ASDKViewController<ASDisplayNode> {
    
    var song: AVAudioPlayer?
    var currentSong: String = ""
    
    private let rootNode: ASDisplayNode = {
        let rootNode = ASDisplayNode()
        rootNode.backgroundColor = .systemBlue
        rootNode.automaticallyManagesSubnodes = true
        
        return rootNode
    }()
    
    private let mainNode: MainNode = MainNode()
    
    override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _, _ -> ASLayoutSpec in
            guard let self = self else { return.init() }
            
            return ASWrapperLayoutSpec(layoutElement: self.mainNode)
        }
        
        currentSong = "Background"
        playInstrument()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.startQuiz(_:)))
        self.rootNode.view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

/* Functionality */
extension ViewController: AVAudioPlayerDelegate {
    
    @objc func startQuiz(_ sender: UITapGestureRecognizer? = nil) {
        stopInstrument()
        
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func playInstrument() {
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
