//
//  Background.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 07.03.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    static func populateBackground(at point: CGPoint, imageName: String)-> Background{
        let background = Background(imageNamed: imageName)
        background.position = point
        background.name = "background"
        background.zPosition = 0
        
        return background
    }
}
