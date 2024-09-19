//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import Firebase
import Combine
import SwiftUI

@MainActor
class InboxViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    @Published var conversations = [Conversation]()
    @Published var user: User?
    @Published var searchText = ""
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return recentMessages
        } else {
            return recentMessages.filter { message in
                guard let user = message.user else { return false }
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var didCompleteInitialLoad = false
    private var firestoreListener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
        observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.user = user
        }.store(in: &cancellables)
        
        InboxService.shared.$documentChanges.sink { [weak self] changes in
            guard let self = self, !changes.isEmpty else { return }
            
            if !self.didCompleteInitialLoad {
                self.loadInitialMessages(fromChanges: changes)
            } else {
                self.updateMessages(fromChanges: changes)
            }
        }.store(in: &cancellables)
    }
    
    func observeRecentMessages() {
        InboxService.shared.observeRecentMessages()
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        self.recentMessages = changes.compactMap{ try? $0.document.data(as: Message.self) }
        
        for i in 0 ..< recentMessages.count {
            let message = recentMessages[i]

            UserService.fetchUser(withUid: message.chatPartnerId) { [weak self] user in
                guard let self else { return }
                self.recentMessages[i].user = user
                
                if i == self.recentMessages.count - 1 {
                    self.didCompleteInitialLoad = true
                }
            }
        }
    }
    
    private func updateMessages(fromChanges changes: [DocumentChange]) {
        for change in changes {
            if change.type == .added {
                self.createNewConversation(fromChange: change)
            } else if change.type == .modified {
                self.updateMessagesFromExisitingConversation(fromChange: change)
            }
        }
    }
    
    private func createNewConversation(fromChange change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }
        
        UserService.fetchUser(withUid: message.chatPartnerId) { user in
            message.user = user
            self.recentMessages.insert(message, at: 0)
            
        }
    }
    
    private func updateMessagesFromExisitingConversation(fromChange change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }
        guard let index = self.recentMessages.firstIndex(where: {
            $0.user?.id ?? "" == message.chatPartnerId
        }) else { return }
        guard let user = self.recentMessages[index].user else { return }
        message.user = user
        
        self.recentMessages.remove(at: index)
        self.recentMessages.insert(message, at: 0)
        
        // Показать уведомление при получении нового сообщения
            showInAppNotification(for: message)
    }
    
    func showInAppNotification(for message: Message) {
        guard let user = message.user else { return }
        
        UIApplication.shared.inAppNotification(
            adaptForDynamicIsland: true,
            timeout: 3,
            swipeToClose: true
        ) {
            HStack(spacing: 10) {
                /// Иконка профиля отправителя
                CircularProfileImageView(user: user, size: .small24)
                
                Text(user.username)
                    .font(.caption)
                    .foregroundStyle(.white)

                Spacer(minLength: 0)

                /// Текст сообщения или иконка чата
                Button(action: {
                    // Можно добавить действие при нажатии, например, переход в чат с пользователем
                }, label: {
                    Image(systemName: "envelope")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.9))
                })
            }
            .padding(.bottom, 1)
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
            }
            .frame(maxWidth: 190)
        }
    }
    
    func deleteMessage(_ message: Message) async throws {
        do {
            recentMessages.removeAll(where: { $0.id == message.id })
            try await InboxService.deleteMessage(message)
        } catch {
            // TODO: If deletion fails add message back at original index
        }
    }
}
