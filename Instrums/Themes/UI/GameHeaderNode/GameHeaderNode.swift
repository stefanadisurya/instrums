//
//  GameHeaderNode.swift
//  Instrums
//
//  Created by Stefan Adisurya on 05/04/22.
//

import Foundation
import AsyncDisplayKit

class GameHeaderNode: ASDisplayNode {
    
    private var score: Int = 0
    
    private lazy var scoreNode: ASTextNode2 = {
        let scoreNode = ASTextNode2()
        
        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .heavy),
            NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(score)", attributes: attrs as [NSAttributedString.Key : Any])
        
        scoreNode.attributedText = attributedString
        
        return scoreNode
    }()
    
    private let helpNode: ASImageNode = {
        let helpNode = ASImageNode()
        helpNode.image = UIImage(systemName: "questionmark.circle")
        helpNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
        helpNode.style.preferredSize = .init(width: 20, height: 20)
        
        return helpNode
    }()
    
    private let exitNode: ASImageNode = {
        let exitNode = ASImageNode()
        exitNode.image = UIImage(systemName: "xmark")
        exitNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
        exitNode.style.preferredSize = .init(width: 20, height: 20)
        
        return exitNode
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let rightStack = ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .center, children: [
            self.helpNode,
            self.exitNode
        ])
        
        let finalStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [
            self.scoreNode,
            rightStack
        ])
        
        return finalStack
    }
    
}
