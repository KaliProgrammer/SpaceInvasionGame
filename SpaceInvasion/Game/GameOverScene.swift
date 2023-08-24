//
//  GameOverScene.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 29.07.2023.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var starfield: SKEmitterNode!
    var gameOver: SKSpriteNode!
    var backToMenuLabel = SKLabelNode(fontNamed: GameOverSceneConstants.font)
    
    override func didMove(to view: SKView) {
        starfieldSetup()
        gameOverLabelSetup()
        backToMenuLabelSetup()
    }
    
    private func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: GameOverSceneConstants.starfield)
        starfield.position = CGPoint(x: GameOverSceneConstants.screenWidth / 2, y: GameOverSceneConstants.screenHeight)
        starfield.advanceSimulationTime(10)
        starfield.zPosition = -GameOverSceneConstants.zPositionForLabel
        
        self.addChild(starfield)
    }
    
    private func gameOverLabelSetup() {
        gameOver = SKSpriteNode(imageNamed: GameOverSceneConstants.gameOver)
        gameOver.size = CGSize(width: GameOverSceneConstants.gameoverSize, height: GameOverSceneConstants.gameoverSize)
        gameOver.position.x = frame.midX
        gameOver.position.y = frame.midY
        gameOver.zPosition = GameOverSceneConstants.zPositionForLabel
        
        let scaleUp = SKAction.scale(to: 3.0, duration: GameOverSceneConstants.durationForGameOverLabel)
        let scaleDown = SKAction.scale(to: 1, duration: GameOverSceneConstants.durationForGameOverLabel)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        gameOver.run(scaleSequence)
        addChild(gameOver)
    }
    
    private func backToMenuLabelSetup() {
        backToMenuLabel.text = GameOverSceneConstants.backToMenuLabel
        backToMenuLabel.fontColor = SKColor.white
        backToMenuLabel.fontSize = GameOverSceneConstants.backToMenuFontSize
        backToMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMenuLabel.zPosition = GameOverSceneConstants.zPositionForLabel
        addChild(backToMenuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            if backToMenuLabel.contains(pointOfTouch) {
                let menuScene = MenuScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: GameOverSceneConstants.durationForScreemTransition)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
        }
    }
}
