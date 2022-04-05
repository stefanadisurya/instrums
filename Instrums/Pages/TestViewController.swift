//
//  TestViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 05/04/22.
//

import Foundation
import AsyncDisplayKit

class TestViewController: ASDKViewController<ASDisplayNode> {
    
    private let rootNode: ASDisplayNode = {
        let rootNode = ASDisplayNode()
        rootNode.backgroundColor = .systemRed
        rootNode.automaticallyManagesSubnodes = true
        
        return rootNode
    }()
    
    private let textNode: ASTextNode2 = {
        let textNode = ASTextNode2()
        textNode.attributedText = .init(string: "HALO")
        
        return textNode
    }()
    
    override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = { [weak self] _, _ -> ASLayoutSpec in
            guard let self = self else { return.init() }
            
            return ASCenterLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumSize, child: self.textNode)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
