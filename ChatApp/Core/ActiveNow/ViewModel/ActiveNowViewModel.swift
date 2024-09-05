//
//  ActiveNowViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 13.08.2023.
//

import Foundation

class ActiveNowViewModel1: ObservableObject {
    @Published var users = [User]()
    private let fetchLimit = 20
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers(limit: fetchLimit)
    }
}


import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = true // Состояние загрузки
    private let fetchLimit = 20
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    @MainActor
    func fetchUsers() async {
        isLoading = true // Начало загрузки
        do {
            self.users = try await UserService.fetchUsers(limit: fetchLimit)
        } catch {
            // Обработка ошибок
            print("Ошибка при загрузке пользователей: \(error)")
        }
        isLoading = false // Конец загрузки
    }
}
