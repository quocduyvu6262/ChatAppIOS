//
//  Functions.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/30/23.
//

import Foundation


extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

func getToken() -> String {
    return UserDefaults.standard.value(forKey: "user_auth_token")! as! String;
}

func getUserID() -> Int {
    return UserDefaults.standard.value(forKey: "id")! as! Int;
}

func getUsername() -> String {
    return UserDefaults.standard.value(forKey: "username")! as! String;
}

func getEmail() -> String {
    return UserDefaults.standard.value(forKey: "email")! as! String;
}

func storeAuthData(id: Int, username: String, email: String, token: String) -> Void {
    UserDefaults.standard.set(token, forKey: "token")
    UserDefaults.standard.set(id, forKey: "id")
    UserDefaults.standard.set(username, forKey: "username")
    UserDefaults.standard.set(email, forKey: "email")
}

func resetAuthData() -> Void {
    UserDefaults.resetDefaults()
    if UserDefaults.standard.string(forKey: "token") == nil &&
        UserDefaults.standard.string(forKey: "id") == nil &&
        UserDefaults.standard.string(forKey: "username") == nil &&
        UserDefaults.standard.string(forKey: "email") == nil
    {
        print("Cleared auth data successfully.")
    } else {
        print("Failed to clear auth data.")
    }
}


func convertObjectToJSONString<T: Encodable>(_ object: T) -> String? {
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(object)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    } catch {
        print("Error converting object to JSON string: \(error)")
    }
    return nil
}

