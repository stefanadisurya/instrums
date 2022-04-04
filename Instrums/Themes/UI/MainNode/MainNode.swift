//
//  MainNode.swift
//  Instrums
//
//  Created by Stefan Adisurya on 04/04/22.
//

import Foundation
import AsyncDisplayKit

class MainNode: ASDisplayNode {
    
    private let appNameNode: ASTextNode2 = {
        let appNameNode = ASTextNode2()
        let attrs = [
            NSAttributedString.Key.font: UIFont(name: "Georgia", size: 60),
            NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Instrums", attributes: attrs as [NSAttributedString.Key : Any])
        
        appNameNode.attributedText = attributedString
        
        return appNameNode
    }()
    
    private let appSubtitleNode: ASTextNode2 = {
        let appSubtitleNode = ASTextNode2()
        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .heavy),
            NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Know your instrument", attributes: attrs as [NSAttributedString.Key : Any])
        
        appSubtitleNode.attributedText = attributedString
        
        return appSubtitleNode
    }()
    
    private let tapAnywhereNode: ASTextNode2 = {
        let tapAnywhereNode = ASTextNode2()
        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Tap anywhere to start", attributes: attrs as [NSAttributedString.Key : Any])
        
        tapAnywhereNode.attributedText = attributedString
        
        return tapAnywhereNode
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        animateTapAnywhereNode()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let upperStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [
            self.appNameNode,
            self.appSubtitleNode
        ])
        
        let centeredNode = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: upperStack)
        let insetedUpperNode = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 200, right: 0), child: centeredNode)
        
        let relativeNode = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: .minimumSize, child: tapAnywhereNode)
        let insetedBottomNode = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 48, right: 0), child: relativeNode)
        
        let finalStack = ASWrapperLayoutSpec(layoutElements: [
            insetedUpperNode,
            insetedBottomNode
        ])
        
        return finalStack
    }
    
    private func animateTapAnywhereNode() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.3
        animation.duration = 1.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        tapAnywhereNode.layer.add(animation, forKey: nil)
    }
    
}
