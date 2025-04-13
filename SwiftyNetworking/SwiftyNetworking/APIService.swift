//
//  APIService.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation
import Pulse
import OSLog


private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.answersai.networking", category: "APIService")


public final class APIService: APIClientExecutable  {
    
    
    private let session: URLSessionProtocol
    private var globalHeaders: [String: String] = [:]
    
    public static let shared = APIService(cookie: nil)
    
    public init(cookie: String?) {
        if let cookie {
            globalHeaders["cookie"] = cookie
        }
        #if DEBUG
        self.session = URLSessionProxy(configuration: .default)
        #else
        self.session = URLSession(configuration: .default)
        #endif
    }
    
    public func execute<T: Decodable>(_ request: APIRequestable) async -> APIResult<T, APIClientError> {
        #if DEBUG
        // Check if stubbed response should be used
        if request.shouldStubResponse,
           let stubbedData = request.stubbedResponseData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: stubbedData)
                return .success(decodedData)
            } catch let error {
                return .failure(APIClientError.other(error))
            }
        }
        #endif
       
        do {
            var urlRequest = try request.asURLRequest()
            globalHeaders.forEach { key, value in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
            
            logger.info("Curl request: \(urlRequest.toCurlString)")
            
            
            let (data, response) = try await session.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                
                if let cookieHeader = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                    let cookie = extractCookie(from: cookieHeader)
                    await setSessionCookie(cookie)
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    if let errorResponse = try? JSONDecoder().decode(APIResponseModel.self, from: data) {
                        return .failure(APIClientError.httpError(errorResponse))
                    }
                    
                    return .failure(APIClientError.httpError(nil))
                }
            }
            
            // takes into consideration an empty body
            if data.isEmpty {
                let emptyData = "{}".data(using: .utf8)!
                let decodedData = try JSONDecoder().decode(T.self, from: emptyData)
                print(emptyData)
                return .success(decodedData)
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch let error as URLError {
            return .failure(APIClientError.urlError(error))
        } catch let decodingError as DecodingError {
            
            decodingError.logError(with: logger)
            
            return .failure(APIClientError.decodingError(decodingError))
        } catch {
            return .failure(APIClientError.other(error))
        }
    }
    
    public func setGlobalHeaders(_ headers: [String: String]) {
        self.globalHeaders = headers
    }
    
    public func setBearerToken(_ token: String) {
        globalHeaders[HeaderConstants.authorization] = "Bearer \(token)"
        logger.debug("Bearer token set")
    }
    
    public func setSessionId(_ sessionId: String) {
        globalHeaders[HeaderConstants.sessionId] = sessionId
        logger.debug("Session ID set")
    }
    
    public func clearSensitiveHeaders() {
        globalHeaders.removeValue(forKey: HeaderConstants.authorization)
        globalHeaders.removeValue(forKey: HeaderConstants.sessionId)
        logger.debug("Sensitive headers cleared")
    }
    
    public func setSessionCookie(_ cookie: String) async {
        globalHeaders["cookie"] = cookie
        do {
            try await StorageManager.save(cookie, for: StorageKeys.cookies.rawValue, in: .keychain)
        } catch {
            logger.error("Error saving cookie: \(error)")
        }
    }
    
    private func extractCookie(from cookieHeader: String) -> String {
        return cookieHeader
    }
}

