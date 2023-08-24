//
//  GameSceneConstants.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 30.07.2023.
//

import Foundation
import UIKit

class GameSceneConstants {
    static let alienCategory: UInt32 = 0xb100
    static let laserCategory: UInt32 = 0b10
    static let playerCategory: UInt32 = 0b1
    static let noneCategory: UInt32 = 0
    static let newLifeCategory : UInt32 = 0b101
    static let fireFrequency: TimeInterval = 0.5
    static let isFiringOn = 1
    static let fireSpeed: TimeInterval = 0.8
    static let fontSize: CGFloat = 32
    static let lives: Int = 3
    static let playerSize: CGFloat = 110
    static let torpedoSize: CGFloat = 15
    static let alienSize: CGFloat = 110
    static let heartSize: CGFloat = 55
    static let keyForTimer: String = "timer"
    static let torpedoNode: String = "torpedo"
    static let font: String = "boldp"
    static let scoreText: String = "Score: 0"
    static let enterYourName: String = "Enter your name"
    static let save: String = "Save"
    static let keyForShip: String = "ship"
    static let dateFormat: String = "dd.MM.yy"
    static let explosion: String = "explosion"
    static let duration: CGFloat = 0.2
}
