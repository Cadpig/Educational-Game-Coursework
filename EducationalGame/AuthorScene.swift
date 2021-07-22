//
//  AuthorScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 02.05.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit

class AuthorScene: SKScene {
    override func didMove(to view: SKView) {
        configureBackground()
        spawnBackButton()
        //spawnLabel()

    }
    fileprivate func configureBackground(){//конфигурация фона
       let screenCenterPoint = CGPoint(x: self.size.width/2, y: self.size.height/2)
       let background = Background.populateBackground(at: screenCenterPoint, imageName: "redlandscapeauthor")
       background.size = self.size
       self.addChild(background)
    }
    
    fileprivate func spawnBackButton(){//создание кнопки "назад"
        let buttonBack = Button.populate(name: "buttonBack", zPos: 1, textureName: "btnback", at: CGPoint(x: 50, y: self.size.height - 50), scale: 0.4)
        self.addChild(buttonBack)
    }
    
    /*fileprivate func spawnLabel(){
        let ruleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        ruleLabel.text = "Данная игра была создана студентом 251 группы факультета КНиИТ Тихоновым Владиславом в качестве курсовой работы."
        ruleLabel.fontSize = 40
        ruleLabel.horizontalAlignmentMode = .right
        ruleLabel.position = CGPoint(x: self.size.width, y: self.size.height/2)
        ruleLabel.fontColor = .black
        ruleLabel.zPosition = 5
        addChild(ruleLabel)
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        
        if node.name == "buttonBack"{
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = SuperMenuScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
