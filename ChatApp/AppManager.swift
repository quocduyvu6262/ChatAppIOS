//
//  AppManager.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/28/23.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    static func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "token") != nil
    }
}
