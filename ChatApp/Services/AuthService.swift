//
//  AuthService.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/27/23.
//

import Foundation


struct SignupRequest: Codable {
    let username: String
    let email: String
    let password: String
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let id: Int?
    let username: String?
    let email: String?
    let token: String?
    let message: String?
    let success: Bool?
}

class AuthService {
    
    //call signup
    func signup(username: String, email: String, password: String, completion: @escaping (Result<AuthResponse, AuthenticationError>) -> Void){
        guard let url = URL(string: "http://localhost:3001/api/auth/signup") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        let body = SignupRequest(username: username, email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else{
                completion(.failure(.invalidSignupCredentials))
                return
            }
            
            guard let token = authResponse.token else {
                completion(.failure(.invalidSignupCredentials))
                return
            }
            
            completion(.success(authResponse))
            
        }.resume()
    }
    
    //call login api on the nodejs server
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, AuthenticationError>) -> Void){
        guard let url = URL(string: "http://localhost:3001/api/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else{
                completion(.failure(.invalidCredentials))
                return
            }
            guard let token = authResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            completion(.success(authResponse))
            
        }.resume()
    }
    
}
