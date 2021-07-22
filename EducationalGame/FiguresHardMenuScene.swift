//
//  MenuScene.swift
//
//
//  Created by Владислав Тихонов on 07.03.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class FiguresHardMenuScene: SKScene {

var xDistance = 150;
var yDistance = 150;

override func didMove(to view: SKView) {
    configureBackground()
    spawnRuleLabel()
    spawnButtons()
    spawnItems()
    

}

 fileprivate func spawnRuleLabel(){
    let ruleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    ruleLabel.text = "Взгляните на фигуры и их названия. Запомните их."
    ruleLabel.fontSize = 20
    ruleLabel.horizontalAlignmentMode = .right
    ruleLabel.position = CGPoint(x: self.size.width - 200, y: self.size.height * 4 / 5)
    ruleLabel.fontColor = .black
    ruleLabel.zPosition = 5
    addChild(ruleLabel)
    
    let ruleLabel2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    ruleLabel2.text = "После начала игры нажимайте на фигуры, название которых написано на экране."
    ruleLabel2.fontSize = 18
    ruleLabel2.horizontalAlignmentMode = .right
    ruleLabel2.position = CGPoint(x: self.size.width - 100, y: self.size.height * 2 / 10)
    ruleLabel2.fontColor = .black
    ruleLabel2.zPosition = 5
    addChild(ruleLabel2)
    
    let ruleLabel3 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    ruleLabel3.text = "Ваша цель - набрать 200 очков. Удачи!"
    ruleLabel3.fontSize = 18
    ruleLabel3.horizontalAlignmentMode = .right
    ruleLabel3.position = CGPoint(x: self.size.width - 300, y: self.size.height * 1 / 10)
    ruleLabel3.fontColor = .black
    ruleLabel3.zPosition = 5
    addChild(ruleLabel3)
    }

 fileprivate func configureBackground(){
    let screenCenterPoint = CGPoint(x: self.size.width/2, y: self.size.height/2)
    let background = Background.populateBackground(at: screenCenterPoint, imageName: "greenLandscapeBg")
    background.size = self.size
    self.addChild(background)
 }
 
 fileprivate func spawnButtons(){
    let buttonRun = Button.populate(name: "buttonRun", zPos: 1, textureName: "play", at: CGPoint(x: self.frame.midX, y: self.frame.midY), scale: 1)
    self.addChild(buttonRun)
    
    let buttonBack = Button.populate(name: "buttonBack", zPos: 1, textureName: "btnback", at: CGPoint(x: 50, y: self.size.height - 50), scale: 0.4)
    self.addChild(buttonBack)
 }
 
 func spawnItems(){
         for i in 1...3{
             let colorName = "fig" + "\(i)"
             let color = SKSpriteNode(imageNamed: colorName)
             color.position = CGPoint(x: xDistance, y: yDistance)
             color.setScale(0.3)
             color.zPosition = 3
             self.addChild(color)
             let xDistance2 = xDistance + 70
             let binName = "figbin" + "\(i)"
             let bin = SKSpriteNode(imageNamed: binName)
             bin.position = CGPoint(x: xDistance2, y: yDistance)
             bin.setScale(0.3)
             bin.zPosition = 2
             self.addChild(bin)
             yDistance += 60
         }
         //xDistance += 400
         xDistance = Int(self.size.width - 250)
         yDistance = 150
         for i in 1...3{
             let colorName = "fig" + "\(i+3)"
             let color = SKSpriteNode(imageNamed: colorName)
             color.position = CGPoint(x: xDistance, y: yDistance)
             color.setScale(0.3)
             color.zPosition = 3
             self.addChild(color)
             let xDistance2 = xDistance + 70
             let binName = "figbin" + "\(i+3)"
             let bin = SKSpriteNode(imageNamed: binName)
             bin.position = CGPoint(x: xDistance2, y: yDistance)
             bin.zPosition = 2
             bin.setScale(0.3)
             self.addChild(bin)
             yDistance += 60
         }
 }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let location = touches.first!.location(in: self)
    let node = self.atPoint(location)
    
    if node.name == "buttonRun"{
        let transition = SKTransition.crossFade(withDuration: 1)
        let gameScene = FiguresHardGameScene(size: self.size)
        gameScene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameScene, transition: transition)
    }
    
    if node.name == "buttonBack"{
        let transition = SKTransition.crossFade(withDuration: 1)
        let gameScene = FiguresDifficultyScene(size: self.size)
        gameScene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameScene, transition: transition)
    }
}

}
