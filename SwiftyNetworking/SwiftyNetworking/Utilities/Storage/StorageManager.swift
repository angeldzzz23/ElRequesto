//
//  StorageManager.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

@MainActor public class StorageManager {
    private static let userDefaultsStorage: UserDefaultsStorage = {
        return UserDefaultsStorage()
    }()
    
    private static let keychainStorage: KeychainStorage = {
        return KeychainStorage()
    }()
    
    private static let fileManager = FileManager.default
    
    private static func getStorage(for type: StorageType) -> StorageProtocol {
        switch type {
            case .userDefaults:
                return userDefaultsStorage
            case .fileSystem(let filename):
                return FileSystemStorage(filename: filename)
            case .keychain:
                return keychainStorage
        }
    }
    
    public static func save<T: Codable>(_ data: T, for key: String, in storageType: StorageType) throws {
        let storage = getStorage(for: storageType)
        try storage.save(data, for: key)
    }
    
    public static func get<T: Codable>(for key: String, from storageType: StorageType) throws -> T? {
        let storage = getStorage(for: storageType)
        return try storage.get(for: key)
    }
    
    public static func delete(for key: String, from storageType: StorageType) throws {
        let storage = getStorage(for: storageType)
        try storage.delete(for: key)
    }
    
    public static func clear() throws {
        // Clear UserDefaults
        try userDefaultsStorage.clear()
        
        // Clear Keychain
        try keychainStorage.clear()
        
        // Clear all files in documents directory
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try fileManager.contentsOfDirectory(
            at: documentsURL,
            includingPropertiesForKeys: nil
        )
        
        for fileURL in fileURLs {
            try fileManager.removeItem(at: fileURL)
        }
    }
}
