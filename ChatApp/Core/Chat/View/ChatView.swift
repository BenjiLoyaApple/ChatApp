//
//  ChatView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @State private var isInitialLoad = false
    @StateObject var viewModel: ChatViewModel
    private let user: User
    private var thread: Thread?
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        VStack {
                            CircularProfileImageView(user: user, size: .xLarge)
                            
                            VStack(spacing: 4) {
                                Text(user.username)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            ChatMessageCell(message: viewModel.messages[index],
                                            nextMessage: viewModel.nextMessage(forIndex: index))
                                .id(viewModel.messages[index].id)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: viewModel.messages) {_, newValue in
                    guard  let lastMessage = newValue.last else { return }
            
                    withAnimation(.spring()) {
                        proxy.scrollTo(lastMessage.id)
                    }
                }
            }
            
            Spacer()
            
            MessageInputView(messageText: $messageText, viewModel: viewModel)
        }
        .onDisappear {
            viewModel.removeChatListener()
        }
        .onChange(of: viewModel.messages, perform: { _ in
            Task { try await viewModel.updateMessageStatusIfNecessary()}
        })
      //  .navigationTitle(user.username)
     //   .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
            ChatView(user: dev.user)
    }
}
