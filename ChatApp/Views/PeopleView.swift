//
//  PeopleView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/29/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.leading, 10)
                .padding(.vertical, 8)
                .background(Color(.systemGray5))
                .cornerRadius(8)

            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(text.isEmpty ? 0 : 1)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}


struct UserItem: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.username)
                .font(.headline)
            Text("Email: \(user.email)")
                .font(.subheadline)
            Divider()
        }
        .padding(.horizontal, 20)
    }
}

struct PeopleView: View {
    @StateObject var peopleVM: PeopleViewModel = PeopleViewModel()
    @Binding var currentMenu: SelectedAuthMenu
    let userID: Int = getUserID()
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Text("Your Friends")
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()
                    NavigationLink(destination: MessageView()){
                        Text("Enter Chat")
                    }

                    Button("Logout") {
                        resetAuthData()
                        AppManager.Authenticated.send(false)
                        currentMenu = .login
                    }
                    .padding(.trailing)
                }.padding()
                SearchBar(text: $peopleVM.searchText)
                ScrollView(){
                    ForEach(peopleVM.userList) { user in
                        if userID != user.id{
                            UserItem(user: user)
                        }
                    }
                }
            }.onAppear{
                peopleVM.getUsers()
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(currentMenu: .constant(.login))
    }
}
