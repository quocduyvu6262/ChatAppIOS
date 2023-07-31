//
//  MessageView.swift
//  ChatApp
//
//  Created by Duy Vu Quoc on 7/30/23.
//

import SwiftUI


struct MessageRow: View {
    let message: ReceivedMessage

    var body: some View {
        HStack {
            if message.sender_id == getUserID() {
                Spacer()
            }

            VStack(alignment: message.sender_id == getUserID() ? .trailing : .leading, spacing: 5) {
                Text(message.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(message.text)
            }
            .padding(10)
            .background(message.sender_id == getUserID() ? Color.blue : Color.green)
            .cornerRadius(10)

            if message.sender_id != getUserID() {
                Spacer()
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
                ForEach(messageVM.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            }
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
