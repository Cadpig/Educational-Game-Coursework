//
//  Bin.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 01.04.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import GameplayKit
import SpriteKit

class Bin: SKSpriteNode {
    static func populate(at point: CGPoint?, binNumber:Int)->Bin{
          let binImageName = configureName(binNumber:binNumber)
          let bin = Bin(imageNamed: binImageName)
          bin.setScale(0.3)
          bin.position = point!
          bin.zPosition = 1
          bin.name = "bin" + "\(binNumber)"
          bin.anchorPoint = CGPoint(x:0.5, y:1.0)
          
          return bin
      }
      
    fileprivate static func configureName(binNumber:Int)->String{
          let imageName = "btn" + "\(binNumber)"
          
          return imageName
          
      }
      
}
