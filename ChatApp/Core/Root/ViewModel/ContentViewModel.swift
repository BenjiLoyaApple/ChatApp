//
//  ContentViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//


import Foundation
import Combine
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var user: User?
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
     //   setupSubscribers()
    }
    
//    private func setupSubscribers() {
//        UserService.shared.$currentUser.sink { [weak self] user in
//            self?.user = user
//        }.store(in: &cancellables)
//        
//        AuthService.shared.$userSession.sink { [weak self] session in
//            self?.userSession = session
//        }.store(in: &cancellables)
//    }
}

