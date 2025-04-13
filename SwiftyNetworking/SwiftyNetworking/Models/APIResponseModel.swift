//
//  APIResponseModel.swift
//  Closetly
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public struct APIResponseModel: Decodable, Sendable, Encodable {
    public let statusCode: Int?
    public let message: String
    
    init(statusCode: Int?, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
}

public struct EmptyAPIResponseModel: Decodable {}
