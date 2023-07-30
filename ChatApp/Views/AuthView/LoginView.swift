//
//  LoginView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/28/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @Binding var currentMenu: SelectedAuthMenu
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Email", text: $loginVM.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $loginVM.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            VStack{
                Button(action: {
                    if !loginVM.email.isEmpty && !loginVM.password.isEmpty {
                        loginVM.login()
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }.padding(.bottom, 3.0)
                
                Button("Sign Up") {
                    currentMenu = .signup
                }.padding(.bottom, 3.0)
                .foregroundColor(.blue)
                .padding()
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
                .padding(.horizontal)
            }.padding()

            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentMenu: .constant(.login))
    }
}
