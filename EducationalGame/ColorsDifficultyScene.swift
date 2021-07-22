//
//  ColorsDifficultyScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 20.04.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class ColorsDifficultyScene: SKScene {
    override func didMove(to view: SKView) {
        configureBackground()
        spawnRuleLabel()
        spawnButtons()
        spawnBackButton()

    }
    
    fileprivate func spawnRuleLabel(){
        let ruleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        ruleLabel.text = "Выберите уровень сложности:"
        ruleLabel.fontSize = 20
        ruleLabel.horizontalAlignmentMode = .right
        ruleLabel.position = CGPoint(x: self.size.width / 2 + 150, y: self.size.height * 4 / 5)
        ruleLabel.fontColor = .black
        ruleLabel.zPosition = 5
        addChild(ruleLabel)
    }
    
    fileprivate func spawnBackButton(){
        let buttonBack = Button.populate(name: "buttonBack", zPos: 1, textureName: "btnback", at: CGPoint(x: 50, y: self.size.height - 50), scale: 0.4)
        self.addChild(buttonBack)
    }
    
    fileprivate func configureBackground(){//конфигурация фона
       let screenCenterPoint = CGPoint(x: self.size.width/2, y: self.size.height/2)
       let background = Background.populateBackground(at: screenCenterPoint, imageName: "greenLandscapeBg")
       background.size = self.size
       self.addChild(background)
    }
    
    fileprivate func spawnButtons(){
        let buttonEasy = Button.populate(name: "difButton1", zPos: 1, textureName: "btncoldif1", at: CGPoint(x: self.frame.midX, y: self.size.height * 3 / 5), scale: 0.5)
        /*let buttonEasy = SKSpriteNode(imageNamed: "btndef1")
        buttonEasy.position = CGPoint(x: self.frame.midX, y: self.size.height * 3 / 5)
        buttonEasy.zPosition = 1
        buttonEasy.name = "difButton1"*/
        self.addChild(buttonEasy)
        
        let buttonMedium = Button.populate(name: "difButton2", zPos: 1, textureName: "btncoldif2", at: CGPoint(x: self.frame.midX, y: self.size.height * 2 / 5), scale: 0.5)
        /*let buttonMedium = SKSpriteNode(imageNamed: "btndef2")
        buttonMedium.position = CGPoint(x: self.frame.midX, y: self.size.height * 2 / 5)
        buttonMedium.zPosition = 1
        buttonMedium.name = "difButtonMedium"*/
        self.addChild(buttonMedium)
        
        let buttonHard = Button.populate(name: "difButton3", zPos: 1, textureName: "btncoldif3", at: CGPoint(x: self.frame.midX, y: self.size.height * 1 / 5), scale: 0.5)
        self.addChild(buttonHard)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "difButton1"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = ColorsEasyMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        if node.name == "difButton2"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = ColorsMediumMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        if node.name == "difButton3"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = ColorsHardMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        if node.name == "buttonBack"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = MainMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
    
}
