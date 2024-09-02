//
//  PreviewProvider.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    var user = User(
            userId: "12345",
            username: "benjiloya",
            fullname: "Benji Loya",
            email: "batman@gmail.com",
            profileImageUrl: nil,
            bio: "Just a superhero in disguise.",
            link: "https://batman.com"
        )
    
    var messages: [Message] = [
        .init(
            messageId: NSUUID().uuidString,
              fromId: "batman",
              toId: "joker",
              text: "Test message for now..",
              timestamp: Timestamp(),
              user: DeveloperPreview.shared.user,
              read: false
             ),
        .init(
            messageId: NSUUID().uuidString,
            fromId: "batman",
            toId: "joker",
            text: "Second test message for now..",
            timestamp: Timestamp(),
            user: DeveloperPreview.shared.user,
            read: false
        )
    ]
    
    lazy var imageUrlString =  "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
    
}
