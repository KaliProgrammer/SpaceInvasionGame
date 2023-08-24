//
//  GameScene.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 28.07.2023.
//

import SpriteKit
import GameplayKit
import CoreMotion
import Combine
import AVFAudio

class GameScene: SKScene {
    
    let gameSceneModel = GameSceneModel()
    let userDefaultsManager: UserDefaultsProtocol = UserDefaultsManager()
    let audioManager = AudioManager()
    
    var heart01: SKSpriteNode!
    var heart02: SKSpriteNode!
    var heart03: SKSpriteNode!
    var scorePublisher = CurrentValueSubject<Int, Never>(1)
    var cancellable = Set<AnyCancellable>()
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var livesLabel: SKLabelNode!
    var backingAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        
        audioManager.setupAudio(resource: Compositions.spaceInvaders.describe())
        starfieldNodeConfigure()
        playerNodeConfigure()
        scoreLabelConfigure()
        heartConfigure()
        setupAlienTimer()
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    //using combine for adding Alien
    private func setupAlienTimer() {
        Timer
            .publish(every: 0.75, on: .main, in: .common)
            .autoconnect()
            .sink {[weak self] _ in
                self?.addAlien()
            }
            .store(in: &cancellable)
    }
    
    private func addAlien() {
        gameSceneModel.aliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: gameSceneModel.aliens) as! [String]
        let alien = SKSpriteNode(imageNamed: gameSceneModel.aliens[0])
        
        alien.size.width = GameSceneConstants.alienSize
        alien.size.height = GameSceneConstants.alienSize
        
        //set interval for enemies positions
        let lowestValueX = self.frame.minX + 50
        let highestValueX = self.frame.maxX - 50
        
        let randomEnemyPosition = GKRandomDistribution(lowestValue: Int(lowestValueX), highestValue: Int(highestValueX))
        
        let positionX = CGFloat(randomEnemyPosition.nextInt())
        
        //set position for each enemy
        alien.position = CGPoint(x: positionX, y: self.size.height)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.affectedByGravity = false
        alien.physicsBody?.categoryBitMask = GameSceneConstants.alienCategory
        alien.physicsBody?.collisionBitMask = GameSceneConstants.noneCategory
        alien.physicsBody?.contactTestBitMask = GameSceneConstants.playerCategory | GameSceneConstants.laserCategory
        
        let speed = userDefaultsManager.loadSimpleObjectTimer(keys: GameSceneConstants.keyForTimer)
        alien.speed = speed
        
        
        self.addChild(alien)
        
        //interval of movement through the screen
        let animationDuration: TimeInterval = 10.0
        var actionArray = [SKAction]()
        let positionXY = CGPoint(x: positionX, y: -self.size.height)
        actionArray.append(SKAction.move(to: positionXY, duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        alien.run(SKAction.sequence(actionArray))
    }
    
    func shootAlien() {
        self.run(SKAction.playSoundFileNamed(Compositions.activateShields.describe(), waitForCompletion: false))
        let torpedo = SKSpriteNode(imageNamed: GameSceneConstants.torpedoNode)
        torpedo.position = player.position
        torpedo.zPosition = 0
        torpedo.physicsBody = SKPhysicsBody(rectangleOf: torpedo.size)
        torpedo.physicsBody?.affectedByGravity = false
        torpedo.physicsBody?.categoryBitMask = GameSceneConstants.laserCategory
        torpedo.physicsBody?.collisionBitMask = GameSceneConstants.noneCategory
        torpedo.physicsBody?.contactTestBitMask = GameSceneConstants.alienCategory
        torpedo.size.width = GameSceneConstants.torpedoSize
        torpedo.size.height = GameSceneConstants.torpedoSize
        
        self.addChild(torpedo)
        
        let shot = SKAction.moveTo(y: self.size.height + player.size.height, duration: 1)
        let deleteExplosion = SKAction.removeFromParent()
        
        let shotSequance = SKAction.sequence([shot, deleteExplosion])
        
        torpedo.run(shotSequance)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shootAlien()
    }
    
    //movement with touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        
        let locationTouch = touch.location(in: self)
        let previousLocationTouch = touch.previousLocation(in: self)
        
        let offsetX = locationTouch.x - previousLocationTouch.x
        
        self.player.position.x += offsetX
        
        if player.position.x > self.frame.maxX - player.size.width/2 {
            player.position.x = self.frame.maxX - player.size.width/2
        }
        
        if player.position.x < self.frame.minX + player.size.width/2 {
            player.position.x = self.frame.minX + player.size.width/2
        }
    }
    
    
    private func starfieldNodeConfigure() {
        starField = SKEmitterNode(fileNamed: "Starfall")
        starField.position = CGPoint(x: GameOverSceneConstants.screenWidth / 2, y: GameOverSceneConstants.screenHeight)
        starField.advanceSimulationTime(10)
        starField.zPosition = -1
        self.addChild(starField)
    }
    
    private func heartConfigure() {
        heart01 = SKSpriteNode(imageNamed: "heart1")
        heart01.position = CGPoint(x: self.frame.minX + 490, y: self.frame.maxY - 132)
        heart01.zPosition = 3
        heart01.size = CGSize(width: GameSceneConstants.heartSize, height: GameSceneConstants.heartSize)
        self.addChild(heart01)
        heart02 = SKSpriteNode(imageNamed: "heart1")
        heart02.position = CGPoint(x: self.frame.minX + 560, y: self.frame.maxY - 132)
        heart02.zPosition = 3
        heart02.size = CGSize(width: GameSceneConstants.heartSize, height: GameSceneConstants.heartSize)
        self.addChild(heart02)
        heart03 = SKSpriteNode(imageNamed: "heart1")
        heart03.position = CGPoint(x: self.frame.minX + 630, y: self.frame.maxY - 132)
        heart03.zPosition = 3
        heart03.size = CGSize(width: GameSceneConstants.heartSize, height: GameSceneConstants.heartSize)
        self.addChild(heart03)
    }
    
    private func playerNodeConfigure() {
        
        let ship = userDefaultsManager.loadSimpleObject(keys: "ship")
        
        player = SKSpriteNode(imageNamed: ship)
        player.size = CGSize(width: GameSceneConstants.playerSize, height: GameSceneConstants.playerSize)
        player.position.x = frame.midX
        player.position.y = frame.minY + player.size.height * 1.2
        player.zPosition = 0
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = GameSceneConstants.playerCategory
        player.physicsBody?.collisionBitMask = GameSceneConstants.noneCategory
        player.physicsBody?.contactTestBitMask = GameSceneConstants.alienCategory | GameSceneConstants.newLifeCategory
        addChild(player)
    }
    
    private func scoreLabelConfigure() {
        scoreLabel = SKLabelNode(text: GameSceneConstants.scoreText)
        scoreLabel.fontSize = GameSceneConstants.fontSize
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: self.frame.minX + 100, y: self.frame.maxY - 150)
        scoreLabel.zPosition = 10
        scoreLabel.fontName = GameSceneConstants.font
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(scoreLabel)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func gameOver() {
        let transition: SKTransition = SKTransition.fade(withDuration: 0.2)
        let scene: SKScene = GameOverScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        saveData()
    }
    
    func saveData()  {
        let alertController = UIAlertController(title: GameSceneConstants.enterYourName, message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: GameSceneConstants.save, style: .default) { [unowned alertController] _ in
            
            //userName
            let answer = alertController.textFields?[0]
            let userName = answer?.text
            guard answer?.text != "" else {
                return
            }
            
            //date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = GameSceneConstants.dateFormat
            formatter.timeZone = .current
            let dateString = formatter.string(from: date)
            
            //ship
            let ship = self.userDefaultsManager.loadSimpleObject(keys: GameSceneConstants.keyForShip)
            let recordScore = RecordModel(date: dateString, score: self.gameSceneModel.score, userName: userName, ship: ship)
            self.userDefaultsManager.saveRecords(recordScore, keys: self.userDefaultsManager.key)
        }
        
        alertController.addAction(submitAction)
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //пулька попадает в пришельца
        if firstBody.categoryBitMask == GameSceneConstants.laserCategory && secondBody.categoryBitMask == GameSceneConstants.alienCategory {
            
            if secondBody.node != nil {
                if secondBody.node!.position.y > self.size.height {
                    return
                } else {
                    hitAlien(explosionPosition: secondBody.node!.position)
                    scorePublisher
                        .receive(on: DispatchQueue.main)
                        .sink {[weak self] newScore in
                            self?.gameSceneModel.score += newScore
                            if let newScore = self?.gameSceneModel.score {
                                self?.scoreLabel.text = "Score: \(newScore)"
                            }
                        }
                        .store(in: &cancellable)
                }
            }
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        
        //столкновение
        
        // handles when enemhy has hit the player
        if firstBody.categoryBitMask == GameSceneConstants.playerCategory && secondBody.categoryBitMask == GameSceneConstants.alienCategory {
            
            // make explosion if player and enemy collide
            if firstBody.node != nil {
                hitAlien(explosionPosition: firstBody.node!.position)
            }
            
            // make explosion if player and enemy collide
            if secondBody.node != nil {
                hitAlien(explosionPosition: secondBody.node!.position)
                loseALife()
            }
            
            secondBody.node?.removeFromParent()
        }
    }
    
    func hitAlien(explosionPosition: CGPoint) {
        
        self.run(SKAction.playSoundFileNamed(Compositions.brokenCircuit.rawValue, waitForCompletion: false))
        // creates explosion
        let explosion = SKSpriteNode(imageNamed: GameSceneConstants.explosion)
        explosion.position = explosionPosition
        explosion.size = CGSize(width: 50, height: 50)
        explosion.zPosition = 3
        self.addChild(explosion)
        
        // make explosion fade in and out
        let scaleIn = SKAction.scale(to: 2.5, duration: 0.1)
        let fadeOut = SKAction.fadeIn(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        // make and run explosion sequence
        let explosiveSequence = SKAction.sequence([scaleIn, fadeOut, delete])
        
        explosion.run(explosiveSequence)
    }
    
    // function that handles what happens when you lose a life
    func loseALife() {
        gameSceneModel.lives -= 1
        
        // make lives label grow and shrink when you lose a life
        let scaleUp = SKAction.scale(to: 1.5, duration: GameSceneConstants.duration)
        let scaleDown = SKAction.scale(to: 1, duration: GameSceneConstants.duration)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        heart01.run(scaleSequence)
        heart02.run(scaleSequence)
        heart03.run(scaleSequence)
        
        // end game when out of lives
        switch gameSceneModel.lives {
        case 0:
            gameOver()
        case 1:
            heart02.isHidden = true
            heart03.isHidden = true
            
        default:
            heart03.isHidden = true
        }
    }
}

