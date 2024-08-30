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

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(email: email, username: username, id: result.user.uid)
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    private func loadUserData() async throws {
        try await UserService.shared.fetchCurrentUser()
    }
    
    @MainActor
    private func uploadUserData(email: String, username: String, id: String) async throws {
        let user = User(username: username, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.UsersCollection.document(id).setData(encodedUser)
    }
    
    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
            InboxService.shared.reset()
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @MainActor
    func deleteUser() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userUID = currentUser.uid
        
        // Удаление пользователя из Firestore
        FirestoreConstants.UsersCollection.document(userUID).delete { [weak self] error in
            if let error = error {
                print("Failed to delete user document: \(error.localizedDescription)")
            } else {
                print("User document successfully deleted from Firestore.")
                
                // Удаление пользователя из Firebase Auth
                currentUser.delete { [weak self] error in
                    if let error = error {
                        print("Failed to delete user from Firebase Auth: \(error.localizedDescription)")
                    } else {
                        print("User successfully deleted from Firebase Auth.")
                        
                        // Очистка данных пользователя
                        self?.userSession = nil
                        UserService.shared.currentUser = nil
                        InboxService.shared.reset()
                    }
                }
            }
        }
    }


}
