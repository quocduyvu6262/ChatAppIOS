//
//  SignupView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/28/23.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @Binding var currentMenu: SelectedAuthMenu
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Email", text: $loginVM.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Username", text: $loginVM.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            SecureField("Password", text: $loginVM.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            VStack{
                
                Button(action: {
                    if !loginVM.email.isEmpty && !loginVM.username.isEmpty && !loginVM.password.isEmpty {
                        loginVM.signup()
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }.padding(.bottom, -5)
                
                Button("Back to login"){
                    currentMenu = .login
                }
            }.padding()

            Spacer()
        }
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(currentMenu: .constant(.signup))
    }
}
