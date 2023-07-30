//
//  ContentView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/27/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var loginVM : LoginViewModel
    @State private var selectedAuthMenu: SelectedAuthMenu = .login
    @State var isAuthenticated = AppManager.isAuthenticated()
    
    
    var body: some View {
        Group {
            if(isAuthenticated){
//                HomeView(currentMenu: $selectedAuthMenu).environmentObject(loginVM)
                PeopleView(currentMenu: $selectedAuthMenu)
            } else {
                switch selectedAuthMenu {
                case .login:
                    LoginView(currentMenu: $selectedAuthMenu)
                case .signup:
                    SignupView(currentMenu: $selectedAuthMenu)
                }
                    
            }
        }.onReceive(AppManager.Authenticated, perform: {
            isAuthenticated = $0
       })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
