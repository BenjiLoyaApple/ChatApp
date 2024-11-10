//
//  DIContainer.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation

class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
    
    // Сервисы, которые не зависят от конкретного пользователя
  //  lazy var authService: AuthServiceProtocol = AuthService()
    lazy var inboxService: InboxServiceProtocol = InboxService.shared
    lazy var messageService: MessageServiceProtocol = MessageService()
    lazy var userService: UserServiceProtocol = UserService.shared as! UserServiceProtocol
    
    // Фабрика для создания экземпляра ChatService с указанным партнером
    func createChatService(chatPartner: User) -> ChatServiceProtocol {
        return ChatService(chatPartner: chatPartner)
    }
    
    private let authProviderType: AuthProviderType = .email // Задайте нужный тип провайдера

       lazy var authService: AuthServiceProtocol = {
           let provider = AuthProviderFactory.createProvider(type: authProviderType)
           return AuthService(provider: provider)
       }()
}
