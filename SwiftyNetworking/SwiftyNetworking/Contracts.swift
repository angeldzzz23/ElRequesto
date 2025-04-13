//
//  Contracts.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public protocol APIClientErrorRepresentable: Error {
    var description: String { get }
}


public protocol APIRequestable: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var queryParams: [URLQueryItem]? { get }
    var method: String { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var shouldStubResponse: Bool { get }
    var stubbedResponseData: Data? { get }
    func asURLRequest() throws -> URLRequest
}

public protocol APIClientExecutable {
    func execute<T: Decodable>(_ request: APIRequestable) async -> APIResult<T, APIClientError>
//    func executeRaw(_ request: APIRequestable) async -> APIResult<DataBinding, APIClientError>

    func setGlobalHeaders(_ headers: [String: String])
    func setBearerToken(_ token: String)
    func setSessionId(_ sessionId: String)
    func clearSensitiveHeaders()
}



public typealias APIResult<T, U> = Result<T, U> where T: Decodable, U: APIClientErrorRepresentable
