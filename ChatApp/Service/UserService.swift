//
//  UserService.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await FirestoreConstants.UsersCollection.document(uid).getDocument()
        self.currentUser = try snapshot.data(as: User.self)
    }
    
    static func fetchUser(uid: String) async throws -> User {
        let snapshot = try await FirestoreConstants.UsersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchUsers(limit: Int? = nil) async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let query = FirestoreConstants.UsersCollection
        
        if let limit {
            let snapshot = try await query.limit(to: limit).getDocuments()
            return mapUsers(fromSnapshot: snapshot, currentUid: currentUid)
        }
        
        let snapshot = try await query.getDocuments()
        return mapUsers(fromSnapshot: snapshot, currentUid: currentUid)
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UsersCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {
                print("DEBUG: Failed to map user")
                return
            }
            completion(user)
        }
    }
    
    private static func mapUsers(fromSnapshot snapshot: QuerySnapshot, currentUid: String) -> [User] {
        return snapshot.documents
            .compactMap({ try? $0.data(as: User.self) })
            .filter({ $0.id !=  currentUid })
    }
}


// MARK: - Update User Data

extension UserService {
    @MainActor
    func updateUserProfileImageUrl(_ profileImageUrl: String) async throws {
        self.currentUser?.profileImageUrl = profileImageUrl
        try await FirestoreConstants.UsersCollection.document(currentUser?.id ?? "").updateData([
            "profileImageUrl": profileImageUrl
        ])
    }
}
