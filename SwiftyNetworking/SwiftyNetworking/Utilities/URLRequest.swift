//
//  URLRequest.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public extension URLRequest {
    var toCurlString: String {
        guard let url = self.url else {
            return "curl command could not be created"
        }
        
        var curlCommand = "curl '\(url.absoluteString)'"
        
        if self.httpMethod != "GET" {
            curlCommand += " -X \(self.httpMethod ?? "GET")"
        }
        
        if let headers = self.allHTTPHeaderFields {
            for (header, value) in headers {
                curlCommand += " -H '\(header): \(value)'"
            }
        }
        
        if let httpBody = self.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8),
           !bodyString.isEmpty {
            curlCommand += " -d '\(bodyString)'"
        }
        
        return curlCommand
    }
}
