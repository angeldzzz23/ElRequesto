//
//  DecodingError.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

import OSLog

public extension DecodingError {
    func logError(with logger: Logger) {
        switch self {
            case .typeMismatch(let type, let context):
                logger.error("Type mismatch error: \(type) - \(context.debugDescription)\nCoding path: \(context.codingPath)")
            case .valueNotFound(let type, let context):
                logger.error("Value not found error: \(type) - \(context.debugDescription)\nCoding path: \(context.codingPath)")
            case .keyNotFound(let key, let context):
                logger.error("Key not found error: \(key.debugDescription) - \(context.debugDescription)\nCoding path: \(context.codingPath)")
            case .dataCorrupted(let context):
                logger.error("Data corrupted error: \(context.debugDescription)\nCoding path: \(context.codingPath)")
            @unknown default:
                logger.error("Unknown decoding error: \(self.localizedDescription)")
        }
    }
}
