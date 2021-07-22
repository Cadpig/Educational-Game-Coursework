//
//  GameScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 07.03.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit
import GameplayKit

class ColorsEasyGameScene: SKScene {
    
    var scoreLabel:SKLabelNode!;
    var scoreNumber = 0;
    
    var buttonPause:Button!;
    var buttonUnpause:Button!;
    var buttonMenu:Button!;
    var menuNode:SKSpriteNode!;
    
    var xDistance = 150;
    
    var blockNode:(SKNode?, Character?);
    var binNode:(SKNode?, Character?);
    
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnBlock()
        spawnBins()
        spawnPauseButton()
        spawnMenuScene()
        
        
}
    fileprivate func spawnPauseButton(){
        buttonPause = Button.populate(name: "buttonPause", zPos: 1, textureName: "btnpause", at: CGPoint(x: 50, y: self.size.height - 50), scale: 0.4)
        self.addChild(buttonPause)
    }
    
    fileprivate func spawnMenuScene(){
        menuNode = SKSpriteNode(imageNamed: "btnbg")
        menuNode.setScale(1)
        menuNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        menuNode.zPosition = 50
        menuNode.name = "menu"
        menuNode.isHidden = true
        addChild(menuNode)
        
        buttonUnpause = Button.populate(name: "buttonUnpause", zPos: 51, textureName: "btnunpause", at: CGPoint(x: self.frame.midX - 50, y: self.frame.midY), scale: 0.4)
        buttonUnpause.isHidden = true
        self.addChild(buttonUnpause)
        
        buttonMenu = Button.populate(name: "buttonMenu", zPos: 51, textureName: "btnmenu", at: CGPoint(x: self.frame.midX + 50, y: self.frame.midY), scale: 0.4)
        buttonMenu.isHidden = true
        self.addChild(buttonMenu)
    }
    
    fileprivate func pauseGame(){
        scene?.isPaused = true
        buttonPause.isHidden = true
        menuNode.isHidden = false
        buttonUnpause.isHidden = false
        buttonMenu.isHidden = false
    }
    
    fileprivate func unpauseGame(){
        scene?.isPaused = false
        buttonPause.isHidden = false
        menuNode.isHidden = true
        buttonUnpause.isHidden = true
        buttonMenu.isHidden = true
    }

    fileprivate func configureStartScene(){
        let screenCenterPoint = CGPoint(x: self.size.width/2, y: self.size.height/2)
        let background = Background.populateBackground(at: screenCenterPoint, imageName: "Background")
        background.size = self.size
        self.addChild(background)
        spawnScoreboard()
    }
    
    func spawnScoreboard(){
        scoreLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        scoreLabel.text = "Очки: \(scoreNumber)"
        scoreLabel.name = "bScore"
        scoreLabel.zPosition = 5
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.size.width - 100, y: self.size.height - 100)
        addChild(scoreLabel)
    }
    
    func spawnBins(){
        for i in 1...2{
            let bin = Bin.populate(at: CGPoint(x:xDistance, y: 300), binNumber: i)
            self.addChild(bin)
            xDistance += 500
        }
    }
    
    func spawnBlock(){
        let spawnBlockWait = SKAction.wait(forDuration: 4)
        let spawnBlockAction = SKAction.run{
            let block = Block.populate(at:CGPoint(x: 0, y: 100), range: 2)
            self.addChild(block)
        }
        let spawnBlockSequence = SKAction.sequence([spawnBlockWait, spawnBlockAction])
        let spawnBlockForever = SKAction.repeatForever(spawnBlockSequence)
        run(spawnBlockForever)
    }
    
    func gameOver(){
        buttonPause.isHidden = true
        
        scoreLabel.isHidden = true
        
        scene?.isPaused = true
        
        let gameOverNode = SKSpriteNode(imageNamed: "btnbg")
        gameOverNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverNode.setScale(1.5)
        gameOverNode.zPosition = 50
        gameOverNode.name = "GameOver"
        addChild(gameOverNode)
        
        buttonMenu.isHidden = false
        
        let buttonNewGame = Button.populate(name: "buttonNewGame", zPos: 51, textureName: "btnagain", at: CGPoint(x: self.frame.midX - 50, y: self.frame.midY), scale: 0.4)
        self.addChild(buttonNewGame)
        
        let endLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        endLabel.text = "Молодец!"
        endLabel.name = "bScore"
        endLabel.zPosition = 51
        endLabel.fontColor = .black
        endLabel.horizontalAlignmentMode = .right
        endLabel.position = CGPoint(x: self.frame.midX + 70 , y: self.frame.midY + 40)
        addChild(endLabel)
        
        
        
    }
    
    override func didSimulatePhysics() {
                enumerateChildNodes(withName: "sprite") { (node, stop) in
                    if node.position.y >= UIScreen.main.bounds.width + 100{
                        node.removeFromParent()
                    }
        }
}

    var movableNode : SKNode?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //scoreLabel.text = "Score: \(scoreNumber)"
        if let touch = touches.first {
            let location = touch.location(in: self)
            let node:SKNode = atPoint(location)
            if node.name == "buttonPause"{
                pauseGame()
            }
            if node.name == "buttonUnpause"{
                unpauseGame()
            }
            if node.name == "buttonMenu"{
                let transition = SKTransition.crossFade(withDuration: 1)
                let gameScene = MainMenuScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameScene, transition: transition)
            }
            let firstLetter = node.name!.index(node.name!.startIndex, offsetBy: 1)
            if (node.name![..<firstLetter] != "b"){//проверяем, нужный ли это узел по первой букве его названия
                let index = node.name!.index(node.name!.startIndex, offsetBy: 6)
                if node.name![..<index] == "sprite" {
                    movableNode = node
                    movableNode?.isPaused = true
                    movableNode!.position = location
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //scoreLabel.text = "Score: \(scoreNumber)"
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //scoreLabel.text = "Score: \(scoreNumber)"
        if let touch = touches.first, movableNode != nil {
            //print(scoreNumber)
            movableNode!.position = touch.location(in: self)
            movableNode = nil
            let nodesAtPoint = nodes(at:touch.location(in: self))
            for i in nodesAtPoint{
                if i.name!.count > 4 {
                    let index = i.name!.index(i.name!.startIndex, offsetBy: 6)
                    if i.name![..<index] == "sprite"{
                        blockNode.0 = atPoint(touch.location(in: self))
                        blockNode.1 = i.name?.last
                        i.removeFromParent()
                        }
                    }
                else{
                    let index = i.name!.index(i.name!.startIndex, offsetBy: 3)
                    if i.name![..<index] == "bin"{
                        binNode.0 = atPoint(touch.location(in: self))
                        binNode.1 = i.name?.last
                    }
                }
            }
            //print(blockNode.1, binNode.1)
            if blockNode.1 == binNode.1/*, blockNode.1 != nil, binNode.1 != nil*/ {//проверка совпадения цветов
                scoreNumber += 20
                scoreLabel.text = "Очки: \(scoreNumber)"
                
            }
            else{
                scoreNumber -= 10
                scoreLabel.text = "Очки: \(scoreNumber)"
            }
            if(scoreNumber >= 200){
                gameOver()
            }
            
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //scoreLabel.text = "Score: \(scoreNumber)"
        if let touch = touches.first {
            let location = touch.location(in: self)
            let node:SKNode = atPoint(location)
            let index = node.name!.index(node.name!.startIndex, offsetBy: 6)
            if node.name![..<index] == "sprite" {
                //movableNode = nil
                node.removeFromParent()
                movableNode?.removeFromParent()
            }
            
        }
    }
}
