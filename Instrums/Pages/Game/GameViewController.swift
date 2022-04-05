//
//  GameViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 05/04/22.
//

import AsyncDisplayKit
import AVFoundation

class GameViewController: ASDKViewController<ASDisplayNode> {
    
    private let rootNode: ASDisplayNode = {
        let rootNode = ASDisplayNode()
        rootNode.backgroundColor = .systemBlue
        rootNode.automaticallyManagesSubnodes = true
        
        return rootNode
    }()
    
    private let gameHeaderNode = GameHeaderNode()
    
    override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _, _ -> ASLayoutSpec in
            guard let self = self else { return.init() }
            
            let insetedHeaderNode = ASInsetLayoutSpec(insets: .init(top: 64, left: 16, bottom: 8, right: 16), child: self.gameHeaderNode)
            
            return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .stretch, children: [
                insetedHeaderNode,
            ])
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
