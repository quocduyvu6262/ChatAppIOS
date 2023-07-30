//
//  PeopleService.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/29/23.
//

import Foundation


struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
}

class PeopleService {
    
    // call fetch users
    func getUsers(completion: @escaping (Result<[User], UserError>) -> Void){
        guard let url = URL(string: "http://localhost:3001/api/users") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No users data")))
                return
            }
            
            guard let users = try? JSONDecoder().decode([User].self, from: data) else {
                completion(.failure(.custom(errorMessage: "Failed to decode users data.")))
                return
            }
            
            completion(.success(users))
            
        }.resume()
    }
}
