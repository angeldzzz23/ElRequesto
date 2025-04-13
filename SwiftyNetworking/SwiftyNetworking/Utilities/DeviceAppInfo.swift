//
//  DeviceAppInfo.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import Foundation
import UIKit
import WebKit

public struct DeviceAppInfo {
    
    public static var installedAppBuildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    public static var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    nonisolated(unsafe) private static var cachedDeviceId: String = {
        return ""
    }()
    
    public static var deviceId: String {
        return cachedDeviceId
    }
    
    nonisolated(unsafe) private static var cachedUserAgent: String = ""
    
    public static var userAgent: String {
        return cachedUserAgent
    }

    @MainActor public static func initialize() {
        let webView = WKWebView(frame: .zero)
        if let agent = webView.value(forKey: "userAgent") as? String {
            cachedUserAgent = agent
        }
        cachedDeviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}


