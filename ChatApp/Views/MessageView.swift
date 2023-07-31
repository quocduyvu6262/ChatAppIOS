//
//  MessageView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/30/23.
//

import SwiftUI


struct MessageRow: View {
    var message: ReceivedMessage
    var prevMessage: ReceivedMessage?
    
    init(message: ReceivedMessage, prevMessage: ReceivedMessage? = nil) {
        self.message = message
        self.prevMessage = prevMessage
    }
    var body: some View {
        HStack {
            if message.sender_id != getUserID() {
                VStack(alignment: .leading){
                    if (prevMessage == nil || (prevMessage != nil && prevMessage?.sender_id != message.sender_id) ){
                        Text(message.username)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                            .padding(.bottom, -5)
                    }
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading, spacing: 5) {
                            Text(message.text)
                                .foregroundColor(.black)
                        }.padding(10)
                        .background(Color.gray)
                        .cornerRadius(10)
                    }
                }
                Spacer()
            } else {
                Spacer()
                HStack(alignment: .bottom){
                    VStack(alignment: .leading, spacing: 5) {
                        Text(message.text)
                            .foregroundColor(.white)
                    }.padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }

        }
    }
}

struct MessageView: View {
    @StateObject var messageVM: MessageViewModel = MessageViewModel()
    @State var message: String = ""
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    ForEach(messageVM.messages.indices, id: \.self){ index in
                        if index > 0 {
                            MessageRow(message: messageVM.messages[index], prevMessage: messageVM.messages[index - 1])
                       } else {
                            MessageRow(message: messageVM.messages[index])
                        }
                    }
                }
            }.padding(.horizontal,8)
            
            HStack {
                TextField("Type your message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    messageVM.sendMessage(message: message)
                    message = ""
                }
            }
            .padding()
        }
        .onAppear(){
            messageVM.connect()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}

