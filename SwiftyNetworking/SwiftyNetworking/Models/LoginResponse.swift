//
//  LoginResponse.swift
//  Closetly
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation


public struct LoginResponse: Decodable, Sendable, Encodable {
    public let message: String?
    public let id: String
    
    init(message: String, id: String) {
        self.message = message
        self.id = id
    }
}


