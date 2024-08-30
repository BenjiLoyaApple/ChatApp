//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var showAlert = false
    @Published var authError: AuthError?
    
    @MainActor
    func createUser() async throws {
        do {
            try await AuthService.shared.createUser(withEmail: email, password: password, username: username, fullname: fullname)
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
        }
    }
}
