//
//  ChatView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct ChatView: View {
    @Environment(\.router) var router
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
            HeaderView()
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        VStack {
                            CircularProfileImageView(user: user, size: .large56)
                            
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
        .navigationBarBackButtonHidden()
        .onDisappear {
            viewModel.removeChatListener()
        }
        .onChange(of: viewModel.messages, perform: { _ in
            Task { try await viewModel.updateMessageStatusIfNecessary()}
        })
        
    }
    
    // MARK: - Header
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Button("Back") {
                    router.dismissScreen()
                }
                .font(.subheadline)
                .foregroundColor(Color.theme.primaryText)
                
                Spacer(minLength: 0)
                
                Spacer(minLength: 0)
                
                
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            
            Divider()
                .offset(y: 8)
        }
        .padding(.top, 10)
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: .mock)
    }
}
