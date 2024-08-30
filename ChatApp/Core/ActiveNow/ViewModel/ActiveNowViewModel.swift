//
//  ActiveNowViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 13.08.2023.
//

import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    private let fetchLimit = 10
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers(limit: fetchLimit)
    }
}
