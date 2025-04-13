//
//  Storage.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public enum StorageType {
    case userDefaults
    case fileSystem(String)
    case keychain
}

public enum StorageError: Error {
    case saveError
    case readError
    case deleteError
    case invalidData
}

public protocol StorageProtocol {
    func save<T: Codable>(_ data: T, for key: String) throws
    func get<T: Codable>(for key: String) throws -> T?
    func delete(for key: String) throws
    func clear() throws
}

public enum StorageKeys: String {
    case onboardingCompleted = "onboardingCompleted"
    case isUserLoggedIn = "isUserLoggedIn"
    case userProfile = "userProfile"
    case loginMethod = "loginMethod"
    case cookies = "cookies"
    case isUserSubscribed = "isUserSubscribed"
    case proModeOnboardingCompleted = "proModeOnboardingCompleted"
    case token = "token"
}
