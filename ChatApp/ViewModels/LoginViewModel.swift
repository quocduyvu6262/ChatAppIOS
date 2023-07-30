//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/27/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    //call AuthService signup
    func signup(){
        AuthService().signup(username: username, email: email, password: password){ result in
            switch result {
                case .success(let authResponse):
                    storeAuthData(id: authResponse.id!, username: authResponse.username!, email: authResponse.email!, token: authResponse.token!)
                    DispatchQueue.main.async {
                        AppManager.Authenticated.send(true)
                    }
                    print("Sign in successfully.")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    //call AuthService login
    func login() {
        AuthService().login(email: email, password: password) { result in
            switch result {
                case .success(let authResponse):
                    storeAuthData(id: authResponse.id!, username: authResponse.username!, email: authResponse.email!, token: authResponse.token!)
                    DispatchQueue.main.async {
                        AppManager.Authenticated.send(true)
                    }
                    print("Log in successfully.")
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
    
}
