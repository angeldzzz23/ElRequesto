//
//  FileSystemStorage.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

class FileSystemStorage: StorageProtocol {
    private let filename: String
    private let fileManager = FileManager.default
    
    init(filename: String) {
        self.filename = filename
    }
    
    private var documentsURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var fileURL: URL {
        documentsURL.appendingPathComponent(filename)
    }
    
    func save<T: Codable>(_ data: T, for key: String) throws {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(data)
            try encoded.write(to: fileURL)
        } catch {
            throw StorageError.saveError
        }
    }
    
    func get<T: Codable>(for key: String) throws -> T? {
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw StorageError.readError
        }
    }
    
    func delete(for key: String) throws {
        guard fileManager.fileExists(atPath: fileURL.path) else { return }
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            throw StorageError.deleteError
        }
    }
    
    func clear() throws {
        try delete(for: "")
    }
}
