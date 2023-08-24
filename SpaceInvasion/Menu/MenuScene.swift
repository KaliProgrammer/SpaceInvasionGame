//
//  MenuScene.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 13.08.2023.
//

import SpriteKit
import AVFAudio

class MenuScene: SKScene, SKPhysicsContactDelegate {
    
    let audioManager: AudioSetting = AudioManager()
    
    var starField: SKEmitterNode!
    var gameNameLabel = SKLabelNode(fontNamed: MenuSceneConstants.font)
    var startGameLabel = SKLabelNode(fontNamed: MenuSceneConstants.font)
    let settingsLabel = SKLabelNode(fontNamed: MenuSceneConstants.font)
    var recordsLabel = SKLabelNode(fontNamed: MenuSceneConstants.font)
    
    override func didMove(to view: SKView) {
        
        audioManager.setupAudio(resource: Compositions.titleScreen.describe())
        starfieldNodeConfigure()
        gameNameLabelSetUp()
        startGameLabelSetUp()
        recordsLabelSetUp()
        settingsLabelSetUp()
    }
    
    // MARK: - Functions
    private func starfieldNodeConfigure() {
        let background = SKSpriteNode(imageNamed: MenuSceneConstants.background)
        background.size = self.frame.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    func gameNameLabelSetUp() {
        gameNameLabel.text = MenuSceneConstants.gameLabel
        gameNameLabel.fontColor = SKColor.white
        gameNameLabel.fontSize = MenuSceneConstants.gameLabelFontSize
        gameNameLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.6)
        gameNameLabel.zPosition = MenuSceneConstants.labelsZPosition
        addChild(gameNameLabel)
    }
    
    func startGameLabelSetUp() {
        startGameLabel.text = MenuSceneConstants.startLabel
        startGameLabel.fontColor = SKColor.white
        startGameLabel.fontSize = MenuSceneConstants.fontSize
        startGameLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.4)
        startGameLabel.zPosition = MenuSceneConstants.labelsZPosition
        addChild(startGameLabel)
    }
    
    func recordsLabelSetUp() {
        recordsLabel.text = MenuSceneConstants.recordLabel
        recordsLabel.fontColor = SKColor.white
        recordsLabel.fontSize = MenuSceneConstants.fontSize
        recordsLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        recordsLabel.zPosition = MenuSceneConstants.labelsZPosition
        addChild(recordsLabel)
    }
    
    func settingsLabelSetUp() {
        settingsLabel.text = MenuSceneConstants.settingLabel
        settingsLabel.fontColor = SKColor.white
        settingsLabel.fontSize = MenuSceneConstants.fontSize
        settingsLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
        settingsLabel.zPosition = MenuSceneConstants.labelsZPosition
        addChild(settingsLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            
            if startGameLabel.contains(pointOfTouch) {
                audioManager.backingAudio.stop()
                let gameScene = GameScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: MenuSceneConstants.duration)
                self.view?.presentScene(gameScene, transition: sceneTransition)
            }
            
            if recordsLabel.contains(pointOfTouch) {
                let recordsScene = RecordsScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: MenuSceneConstants.duration)
                view?.presentScene(recordsScene, transition: sceneTransition)
            }
            
            if settingsLabel.contains(pointOfTouch) {
                let recordsScene = SettingsScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: MenuSceneConstants.duration)
                view?.presentScene(recordsScene, transition: sceneTransition)
            }
        }
    }
}
