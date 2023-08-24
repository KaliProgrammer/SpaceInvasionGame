//
//  GameOverSceneConstants.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 30.07.2023.
//

import Foundation
import SpriteKit

class GameOverSceneConstants {
    static let screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
    static let screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
    static let gameoverSize: CGFloat = 300
    static let font: String = "boldp"
    static let starfield: String = "Starfall"
    static let gameOver: String = "gameover4"
    static let backToMenuLabel: String = "back to menu"
    static let backToMenuFontSize: CGFloat = 40
    static let durationForGameOverLabel:CGFloat = 0.2
    static let durationForScreemTransition: CGFloat = 0.5
    static let zPositionForLabel: CGFloat = 1
}
