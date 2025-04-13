//
//  LoginPostApi.swift
//  Closetly
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation

public struct LoginPostApi: APIRequestable, Sendable {
    public var method = "POST"
    public var path: String = "/api/login/Login"
}
