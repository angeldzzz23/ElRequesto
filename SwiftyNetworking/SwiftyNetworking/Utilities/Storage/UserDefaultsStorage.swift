//
//  UserDefaultsStorage.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

class UserDefaultsStorage: StorageProtocol {
    private let defaults = UserDefaults.standard
    
    func save<T: Codable>(_ data: T, for key: String) throws {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(data)
            defaults.set(encoded, forKey: key)
        } catch {
            throw StorageError.saveError
        }
    }
    
    func get<T: Codable>(for key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw StorageError.readError
        }
    }
    
    func delete(for key: String) throws {
        defaults.removeObject(forKey: key)
    }
    
    func clear() throws {
        
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
