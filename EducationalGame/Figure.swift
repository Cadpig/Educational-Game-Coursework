//
//  Figure.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 07.03.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Figure: SKSpriteNode {
    
    var figureType:Int = 0

    static func populate(at point: CGPoint?, range: Int)->Figure{
        let rNumber = configureName(range: range)
        let figureImageName = "fig" + "\(rNumber)"
        let figure = Figure(imageNamed: figureImageName)
        figure.figureType = rNumber
        figure.setScale(0.3)
        figure.position = point!
        figure.zPosition = 2
        figure.name = "fig"
        figure.anchorPoint = CGPoint(x:0.5, y:1.0)
        figure.run(rotateForRandomAngle())
        figure.run(move(from: figure.position))
        
        return figure
    }
    
  fileprivate static func configureName(range: Int)->Int{
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: range)
        let randomNumber = distribution.nextInt()
        
        return randomNumber
        
    }
    
   fileprivate static func rotateForRandomAngle()->SKAction{
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
        
    }
    
    fileprivate static func move(from point:CGPoint)->SKAction{
        let screen = UIScreen.main.bounds
        let movePoint = CGPoint(x: screen.width + 100, y: point.y)
        let moveDistance = point.y + 200
        let movementSpeed:CGFloat = 50.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
