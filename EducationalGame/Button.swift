//
//  Button.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 20.04.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class Button: SKSpriteNode {
    static func populate(name: String, zPos: Int, textureName: String, at point: CGPoint?, scale: CGFloat)->Button{
        let button = Button(imageNamed: textureName)
        button.zPosition = CGFloat(zPos)
        button.name = name
        button.setScale(scale)
        button.position = point!
        
        return button
        
    }
}
