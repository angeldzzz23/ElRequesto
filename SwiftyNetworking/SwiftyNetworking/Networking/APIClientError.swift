//
//  APIClientError.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public enum APIClientError: APIClientErrorRepresentable {
    case badURL
    case urlError(URLError)
    case decodingError(DecodingError)
    case httpError(APIResponseModel?)
    case other(Error)
    case unauthorized
    case verificationIdNil
    case userIdTokenNil
    case phoneOtpVerificationFailed(Error)
    case unknownError
    
    public var description: String {
        switch(self) {
            case .badURL:
                return "Couldn't form url request, bad url!"
            case .urlError(let error):
                return "URL error: \(error.localizedDescription)"
            case .decodingError(let error):
                return "Decoding error: \(error.localizedDescription)"
            case .httpError(let statusCode):
                return "HTTP error: \(String(describing: statusCode))"
            case .other(let error):
                return error.localizedDescription
            case .unauthorized:
                return "Unauthorized access"
            case .verificationIdNil:
                return "Verification id is nil"
            case .userIdTokenNil:
                return "User id token is nil"
            case .phoneOtpVerificationFailed(let error):
                return "Phone otp verification failed: \(error.localizedDescription)"
            case .unknownError:
                return "Unknown error"
        }
    }
}
