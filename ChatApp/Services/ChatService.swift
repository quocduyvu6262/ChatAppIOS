//
//  MessageService.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/28/23.
//

import Foundation
import SocketIO

struct MessageToSend: Codable {
    let sender_id: Int
    let username: String
    let text: String
}

struct ReceivedMessage: Codable, Hashable {
    let id: Int
    let sender_id: Int
    let username: String
    let text: String
    let createdAt: String
}

class ChatService: NSObject {
    static let shared = ChatService()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    var username: String!
    
    override init(){
        super.init()
        
        manager = SocketManager(socketURL: URL(string: "http://localhost:3001")!)
        socket = manager.defaultSocket
    }
    
    func connect(){
        socket.connect()
    }
    
    func disconnect(){
        socket.disconnect()
    }
    
    func sendMessage(_ message: String){
        let messageToSend = MessageToSend(sender_id: getUserID(), username: getUsername(), text: message)
        if let messageToSendJsonString = convertObjectToJSONString(messageToSend) {
            socket.emit("sendMessage", messageToSendJsonString)
        }
    }
    
    func receiveMessage(_ completion: @escaping (Int, Int, String, String, String) -> Void){
        socket.on("receiveMessage") { data, _ in
            if let id = data[0] as? Int,
               let sender_id = data[1] as? Int,
               let username = data[2] as? String,
               let text = data[3] as? String,
               let createdAt = data[4] as? String {
                print("Receive Message here")
                completion(id, sender_id, username, text, createdAt)
            } else {
                print("Failed to receive message in client")
            }
        }
    }
    
    // call fetch users
    func getAllMessage(completion: @escaping (Result<[ReceivedMessage], UserError>) -> Void){
        guard let url = URL(string: "http://localhost:3001/api/messages") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No messages data")))
                return
            }
            
            guard let messages = try? JSONDecoder().decode([ReceivedMessage].self, from: data) else {
                completion(.failure(.custom(errorMessage: "Failed to decode messages data.")))
                return
            }
            
            completion(.success(messages))
            
        }.resume()
    }
}
