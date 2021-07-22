//
//  SuperMenuScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 07.05.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class SuperMenuScene: SKScene {
    override func didMove(to view: SKView) {
        configureBackground()
        spawnButtons()
        spawnRuleLabel()

    }
    
    fileprivate func spawnRuleLabel(){
    let ruleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    ruleLabel.text = "Обучающие миниигры"
    ruleLabel.fontSize = 40
    ruleLabel.horizontalAlignmentMode = .right
    ruleLabel.position = CGPoint(x: self.size.width - 250, y: self.size.height * 4 / 5)
    ruleLabel.fontColor = .black
    ruleLabel.zPosition = 5
    addChild(ruleLabel)
    }
    
    fileprivate func configureBackground(){//конфигурация фона
       let screenCenterPoint = CGPoint(x: self.size.width/2, y: self.size.height/2)
       let background = Background.populateBackground(at: screenCenterPoint, imageName: "redlandscapeBg")
       background.size = self.size
       self.addChild(background)
    }
    
    fileprivate func spawnButtons(){//создание кнопок
        let buttonPlay = Button.populate(name: "PlayButton", zPos: 1, textureName: "btnbegin", at: CGPoint(x: self.frame.midX, y: self.frame.midY), scale: 0.8)
        /*SKSpriteNode(imageNamed: "colorsmode")
        buttonColors.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        buttonColors.zPosition = 1
        buttonColors.name = "runButton"*/
        self.addChild(buttonPlay)
        
        let buttonAuthor = Button.populate(name: "AuthorButton", zPos: 1, textureName: "authorbtn", at: CGPoint(x: self.size.width - 50, y: 50), scale: 0.3)
        self.addChild(buttonAuthor)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "PlayButton"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = MainMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        if node.name == "AuthorButton"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = AuthorScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
    }
    
}
