//
//  PeopleViewModel.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/29/23.
//

import Foundation
import Combine




class PeopleViewModel: ObservableObject{
    @Published var users: [User] = []
    @Published var searchText: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.username.lowercased().contains(searchText.lowercased()) }
        }
    }
    var userList: [User] {
        filteredUsers
    }
    
    //call getUsers
    func getUsers(){
        PeopleService().getUsers(){ result in
            switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                    print("Fetch all users successfully.")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
