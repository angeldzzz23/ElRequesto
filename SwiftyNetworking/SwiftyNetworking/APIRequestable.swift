//
//  APIRequestable.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation


public extension APIRequestable {
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryParams
        
        guard let url = components?.url else {
            throw APIClientError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        let defaultHeaders = [
            HeaderConstants.accept: HeaderConstants.applicationJson,
            HeaderConstants.contentType: HeaderConstants.applicationJson,
            HeaderConstants.userAgent: DeviceAppInfo.userAgent
        ]
        
        // Merge default headers with custom headers
        defaultHeaders.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}

public extension APIRequestable {
    var baseURL: String {
#if DEBUG
        return "https://67fb1b628ee14a5426294667.mockapi.io"
#else
        return "https://67fb1b628ee14a5426294667.mockapi.io"
#endif
    }
    var queryParams: [URLQueryItem]? { nil }
    var body: Data? { nil }
    var headers: [String: String]? { nil }
    var shouldStubResponse: Bool { false }
    var stubbedResponseData: Data? { nil }
}
