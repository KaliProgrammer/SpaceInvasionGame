//
//  RecordModel.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 13.08.2023.
//

import Foundation

struct RecordModel: Codable {
    var date: String?
    var score: Int?
    var userName: String?
    var ship: String?
    
    var timer: Double?

    private enum CodingKeys: String, CodingKey {
        case date
        case score
        case userName
        case ship
        case timer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(score, forKey: .score)
        try container.encode(userName, forKey: .userName)
        try container.encode(ship, forKey: .ship)
        try container.encode(timer, forKey: .timer)
    }
}
