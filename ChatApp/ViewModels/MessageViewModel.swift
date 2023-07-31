//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/30/23.
//

import Foundation


class MessageViewModel: ObservableObject {
    @Published var messages: [ReceivedMessage] = []
    @Published var selectedPerson: String = ""
    
    
    func connect() {
        self.getAllMessages()
        ChatService.shared.connect()
        ChatService.shared.receiveMessage() { id, sender_id, username, text, createdAt in
            self.receiveMessage(id: id, sender_id: sender_id, username: username, text: text, createdAt: createdAt)
        }
    }
    
    func sendMessage(message: String){
        ChatService.shared.sendMessage(message)
    }
    
    func receiveMessage(id: Int, sender_id: Int, username: String, text: String, createdAt: String){
        DispatchQueue.main.async {
            self.messages.append(ReceivedMessage(id: id, sender_id: sender_id, username: username, text: text, createdAt: createdAt))
        }
    }
    
    func getAllMessages(){
        ChatService.shared.getAllMessage(){ result in
            switch result {
                case .success(let messages):
                    DispatchQueue.main.async {
                        self.messages = messages
                    }
                    print("Fetch all previous messages successfully.")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
