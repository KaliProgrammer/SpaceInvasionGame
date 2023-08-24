//
//  RecordModel.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 13.08.2023.
//

import Foundation

protocol UserDefaultsProtocol {
    func saveRecords<T: Codable>(_ records: T, keys: String)
    func loadRecords<T: Codable>(keys: String) -> [T]
    func saveSimpleObject(_ records: String, keys: String)
    func loadSimpleObject(keys: String) -> String
    func loadSimpleObjectTimer(keys: String) -> Double
    func saveSimpleObjectTimer(_ records: Double, keys: String)
    var key: String { get set }
}

class UserDefaultsManager: UserDefaultsProtocol {
    
    enum UserDefaultsKeys: String {
        case recordKey
    }
    var key = UserDefaultsKeys.recordKey.rawValue
    
    func saveRecords<T: Codable>(_ records: T, keys: String) {
        var arrayOfRecords: [T] = loadRecords(keys: keys)
        arrayOfRecords.append(records)
        UserDefaults.standard.setData(encodable: arrayOfRecords, keys)
    }
    
    func loadRecords<T: Codable>(keys: String) -> [T] {
        guard let records = UserDefaults.standard.getData([T].self, keys) else {
            return []
        }
        return records
    }
    
    func loadSimpleObject(keys: String) -> String {
        guard let records = UserDefaults.standard.object(forKey: keys) else {
            return ""
        }
        return records as! String
    }
    
    func saveSimpleObject(_ records: String, keys: String) {
        UserDefaults.standard.set(records, forKey: keys)
    }
    
    func loadSimpleObjectTimer(keys: String) -> Double {
        guard let records = UserDefaults.standard.object(forKey: keys) else {
            return 0.0
        }
        return records as! Double
    }
    
    func saveSimpleObjectTimer(_ records: Double, keys: String) {
        UserDefaults.standard.set(records, forKey: keys)
    }
}



