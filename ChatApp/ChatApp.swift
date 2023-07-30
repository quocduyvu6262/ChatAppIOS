//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/27/23.
//

import SwiftUI

@main
struct ChatApp: App {
    @StateObject private var loginVM : LoginViewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(loginVM)
        }
    }
}
