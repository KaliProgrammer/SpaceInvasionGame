//
//  UserDefaults+Extension.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 16.08.2023.
//

import Foundation

extension UserDefaults {
    
    func setData<T: Encodable>(encodable: T, _ key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func getData<T: Decodable>(_ type: T.Type, _ key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
