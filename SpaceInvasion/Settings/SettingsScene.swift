//
//  SettingsScene.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 15.08.2023.
//

import Foundation
import SpriteKit
import AVFAudio

class SettingsScene: SKScene {
    let userDefaultsManager: UserDefaultsProtocol = UserDefaultsManager()
    let background = SKSpriteNode(imageNamed: SettingsSceneConstants.background)

    let rookieLabel = SKLabelNode(fontNamed: SettingsSceneConstants.font)
    let warriorLabel = SKLabelNode(fontNamed: SettingsSceneConstants.font)
    
    let backToMenuLabel = SKLabelNode(fontNamed: SettingsSceneConstants.font)

    let rookieSpaceship = SKSpriteNode(imageNamed: SettingsSceneConstants.rookieSpaceship)
    let warriorSpaceship = SKSpriteNode(imageNamed: SettingsSceneConstants.warriorSpaceship)

    let rookieSpeed = 1.0
    let warriorSpeed = 5.0
    
    var chooseShipLabel = SKLabelNode(fontNamed: SettingsSceneConstants.font)

    override func didMove(to view: SKView) {
        backgroundSetUp()
        chooseLabelSetUp()
        rookieShipSetUp()
        warriorShipSetUp()
        rookieLabelSetup()
        warriorLabelSetup()
    }
    
    func chooseLabelSetUp() {
        chooseShipLabel.text = SettingsSceneConstants.chooseShipLabel
        chooseShipLabel.fontColor = SKColor.white
        chooseShipLabel.fontSize = SettingsSceneConstants.chooseShipLabelFontSize
        chooseShipLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7)
        chooseShipLabel.zPosition = SettingsSceneConstants.labelsZPosition
        addChild(chooseShipLabel)
    }


    func backgroundSetUp() {
        background.size = self.frame.size
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        background.zPosition = SettingsSceneConstants.backgroundZPosition
        addChild(background)
    }

    func rookieShipSetUp() {
        rookieSpaceship.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.55)
        rookieSpaceship.zPosition = SettingsSceneConstants.labelsZPosition
        rookieSpaceship.size = CGSize(width: SettingsSceneConstants.shipSize, height: SettingsSceneConstants.shipSize)
        addChild(rookieSpaceship)
    }

    func warriorShipSetUp() {
        warriorSpaceship.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.55)
        warriorSpaceship.zPosition = SettingsSceneConstants.labelsZPosition
        warriorSpaceship.size = CGSize(width: SettingsSceneConstants.shipSize, height: SettingsSceneConstants.shipSize)
        addChild(warriorSpaceship)
    }
    
    func rookieLabelSetup() {
        rookieLabel.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.45)
        rookieLabel.fontColor = SKColor.white
        rookieLabel.zPosition = 1
        rookieLabel.text = SettingsSceneConstants.rookieLabel
        rookieLabel.fontSize = SettingsSceneConstants.labelSize
        addChild(rookieLabel)
    }
    
    func warriorLabelSetup() {
        warriorLabel.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.45)
        warriorLabel.fontColor = SKColor.white
        warriorLabel.zPosition = 1
        warriorLabel.text = SettingsSceneConstants.warriorLabel
        warriorLabel.fontSize = SettingsSceneConstants.labelSize

        addChild(warriorLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            if rookieSpaceship.contains(pointOfTouch) {
                let ship = SettingsSceneConstants.rookieSpaceship
                userDefaultsManager.saveSimpleObject(ship, keys: SettingsSceneConstants.keyForShip)
                userDefaultsManager.saveSimpleObjectTimer(rookieSpeed, keys: SettingsSceneConstants.keyForTimer)
                let gameScene = GameScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: SettingsSceneConstants.duration)
                self.view?.presentScene(gameScene, transition: sceneTransition)

            } else if warriorSpaceship.contains(pointOfTouch) {

                let ship = SettingsSceneConstants.warriorSpaceship
                userDefaultsManager.saveSimpleObject(ship, keys: SettingsSceneConstants.keyForShip)
                userDefaultsManager.saveSimpleObjectTimer(warriorSpeed, keys: SettingsSceneConstants.keyForTimer)
                let gameScene = GameScene(size: self.size)
                let sceneTransition = SKTransition.fade(withDuration: SettingsSceneConstants.duration)
                self.view?.presentScene(gameScene, transition: sceneTransition)
            }
        }
    }
}
