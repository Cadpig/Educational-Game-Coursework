//
//  GameScene.swift
//  EducationalGame
//
//  Created by Владислав Тихонов on 07.03.2021.
//  Copyright © 2021 Владислав Тихонов. All rights reserved.
//

import SpriteKit
import GameplayKit

class FiguresEasyGameScene: SKScene {

    let figureNames = ["Круги", "Квадраты", "Трапеции", "Треугольники", "Овалы", "Ромбы"]
    var figureNumber = 0
    var figureLabel:SKLabelNode!
    
    var buttonPause:Button!;
    var buttonUnpause:Button!;
    var buttonMenu:Button!;
    var menuNode:SKSpriteNode!;
      
    var scoreLabel:SKLabelNode!;
    var scoreNumber = 0;
    
    var xDistance = 150;
    var blockNode:(SKNode?, Character?);
    var binNode:(SKNode?, Character?);
    
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnFigure()
        spawnFigureName()
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
    
    func spawnFigureName(){
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 1)
        figureNumber = distribution.nextInt()
        figureLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        figureLabel.text = "Нажимайте на \(figureNames[figureNumber])"
        figureNumber += 1
        figureLabel.name = "bName"
        figureLabel.zPosition = 5
        figureLabel.horizontalAlignmentMode = .right
        figureLabel.position = CGPoint(x: 400, y: self.size.height - 100)
        addChild(figureLabel)
    }
    
    func gameOver(){
        buttonPause.isHidden = true
        
        scoreLabel.isHidden = true
        figureLabel.isHidden = true
        
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
    
    func spawnFigure(){
        let spawnFigureWait = SKAction.wait(forDuration: 2)
        let spawnFigureAction = SKAction.run{
            let figure = Figure.populate(at:CGPoint(x: 0, y: 100), range: 2)
            self.addChild(figure)
        }
        let spawnFigureSequence = SKAction.sequence([spawnFigureWait, spawnFigureAction])
        let spawnFigureForever = SKAction.repeatForever(spawnFigureSequence)
        run(spawnFigureForever)
    }
    
    
    override func didSimulatePhysics() {
                enumerateChildNodes(withName: "fig") { (node, stop) in
                    if node.position.x > self.size.width + 20 /*UIScreen.main.bounds.width*/{
                        node.removeFromParent()
                    }
        }
}

    //var movableNode : SKNode?

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
            if node.name == "buttonNewGame"{
                let transition = SKTransition.crossFade(withDuration: 1)
                let gameScene = FiguresEasyGameScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameScene, transition: transition)
            }
            if node.name == "fig"{
                let figureNode = node as! Figure
                if figureNode.figureType == figureNumber{
                    node.removeFromParent()
                    scoreNumber += 20
                    scoreLabel.text = "Очки: \(scoreNumber)"
                    let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 1)
                    figureNumber = distribution.nextInt()
                    figureLabel.text = "Нажимайте на \(figureNames[figureNumber])"
                    figureNumber += 1
                    
                }
                else{
                    scoreNumber -= 10
                    scoreLabel.text = "Очки: \(scoreNumber)"
                }
                if(scoreNumber >= 200){
                    gameOver()
                }
            }
           /* let firstLetter = node.name!.index(node.name!.startIndex, offsetBy: 1)//проверяем, нужный ли это узел по первой букве его названия
            if (node.name![..<firstLetter] != "b"){
                let index = node.name!.index(node.name!.startIndex, offsetBy: 6)
                if node.name![..<index] == "sprite" {
                    movableNode = node
                    movableNode?.isPaused = true
                    movableNode!.position = location
                }
            }*/
        }
    }

}
