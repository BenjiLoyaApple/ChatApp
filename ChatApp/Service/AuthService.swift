//
//  AuthService.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class AuthService: AuthServiceProtocol {
    private let provider: AuthProviderProtocol
    
    init(provider: AuthProviderProtocol) {
        self.provider = provider
    }
    
    var userSession: FirebaseAuth.User? {
        return provider.userSession
    }
    
    func login(withEmail email: String, password: String) async throws {
        try await provider.signIn(email: email, password: password)
    }
    
    func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws {
        try await provider.createUser(email: email, password: password, username: username, fullname: fullname)
    }
    
    func signOut() async throws {
        try await provider.signOut()
    }
    
    func deleteUser() async throws {
        try await provider.deleteUser()
    }
}


class EmailAuthProvider: AuthProviderProtocol {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
    }
    
    func createUser(email: String, password: String, username: String, fullname: String?) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        
        // Сохранение дополнительной информации о пользователе
        let user = result.user
        try await saveUserData(userId: user.uid, email: email, username: username, fullname: fullname)
    }

    private func saveUserData(userId: String, email: String, username: String, fullname: String?) async throws {
        let user = User(
            username: username,
            fullname: fullname ?? "", // `fullname` опционален
            email: email,
            profileImageUrl: nil
        )
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.UsersCollection.document(userId).setData(encodedUser)
    }

    func signOut() async throws {
        try Auth.auth().signOut()
        self.userSession = nil
    }
    
    func deleteUser() async throws {
        guard let currentUser = Auth.auth().currentUser else { return }
        try await currentUser.delete()
        self.userSession = nil
    }
}
