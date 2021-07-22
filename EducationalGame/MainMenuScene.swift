//
//  MainMenuScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 15.04.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        configureBackground()
        spawnButtons()
        spawnRuleLabel()

    }
    
    fileprivate func spawnRuleLabel(){
    let ruleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    ruleLabel.text = "Выберите миниигру:"
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
        let buttonColors = Button.populate(name: "ColorsButton", zPos: 1, textureName: "colorsmode", at: CGPoint(x: self.frame.midX, y: self.frame.midY), scale: 0.8)
        /*SKSpriteNode(imageNamed: "colorsmode")
        buttonColors.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        buttonColors.zPosition = 1
        buttonColors.name = "runButton"*/
        self.addChild(buttonColors)
        
        let buttonFigures = Button.populate(name: "FiguresButton", zPos: 1, textureName: "figuresmode", at: CGPoint(x: self.frame.midX, y: self.frame.midY - 100), scale: 0.8)
        /*SKSpriteNode(imageNamed: "figuresmode")
        buttonFigures.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        buttonFigures.zPosition = 1
        buttonFigures.name = "FiguresButton"*/
        self.addChild(buttonFigures)
        
        
        let buttonBack = Button.populate(name: "buttonBack", zPos: 1, textureName: "btnback", at: CGPoint(x: 50, y: self.size.height - 50), scale: 0.4)
        self.addChild(buttonBack)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "ColorsButton"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = ColorsDifficultyScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        if node.name == "FiguresButton"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = FiguresDifficultyScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        
        if node.name == "buttonBack"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = SuperMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
    
}
