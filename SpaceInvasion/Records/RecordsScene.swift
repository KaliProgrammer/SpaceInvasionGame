//
//  RecordsScene.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 14.08.2023.
//

import Foundation
import SpriteKit
import UIKit
import SnapKit
import AVFAudio

class RecordsScene: SKScene {
    
    var tableView = RecordsTableView()
    let tableViewSize = CGSize(width: RecordSceneConstants.tableViewWidth, height: RecordSceneConstants.tableViewHeight)
    let cell = UITableViewCell()
    let backToMenuLabel = SKLabelNode(fontNamed: RecordSceneConstants.font)
    let userDefaultsManager: UserDefaultsProtocol = UserDefaultsManager()
    let audioManager: AudioSetting = AudioManager()
    
    
    override func didMove(to view: SKView) {
        
        //to delete data from UserDefaults
        // UserDefaults.standard.removeObject(forKey: userDefaultsManager.key)
        
        audioManager.setupAudio(resource: Compositions.spaceInvaders.describe())
        backgroundSetUp()
        tableViewSetup()
        backToMainMenuLabelSetUp()
    }
    
    func backgroundSetUp() {
        let background = SKSpriteNode(imageNamed: RecordSceneConstants.backgroundImage)
        background.size = self.frame.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    func tableViewSetup() {
        tableView.backgroundColor = .clear
        tableView.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseIdentifier)
        self.tableView.frame = CGRect(x: RecordSceneConstants.x,
                                      y: RecordSceneConstants.y,
                                      width: self.tableViewSize.width,
                                      height: self.tableViewSize.height)
        scene?.view?.addSubview(tableView)
        tableView.reloadData()
    }
    
    func backToMainMenuLabelSetUp() {
        backToMenuLabel.text = RecordSceneConstants.backToMenu
        backToMenuLabel.fontColor = .white
        backToMenuLabel.fontSize = RecordSceneConstants.fontSize
        backToMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMenuLabel.zPosition = 1
        addChild(backToMenuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            
            if backToMenuLabel.contains(pointOfTouch) {
                tableView.removeFromSuperview()
                let menuScene = MenuScene(size: self.size)
                let transition = SKTransition.fade(withDuration: RecordSceneConstants.duration)
                view?.presentScene(menuScene, transition: transition)
            }
        }
    }
}
