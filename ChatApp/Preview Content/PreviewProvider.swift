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
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    let user = User(
            userId: "12345",
            username: "benjiloya",
            fullname: "Benji Loya",
            email: "batman@gmail.com",
            profileImageUrl: nil,
            bio: "Just a superhero in disguise.",
            link: "https://batman.com"
        )
    
    let messages: [Message] = [
        .init(
            messageId: NSUUID().uuidString,
              fromId: "batman",
              toId: "joker",
              text: "Test message for now..",
              timestamp: Timestamp(),
              user: DeveloperPreview.instance.user,
              read: false
             ),
        .init(
            messageId: NSUUID().uuidString,
            fromId: "batman",
            toId: "joker",
            text: "Second test message for now..",
            timestamp: Timestamp(),
            user: DeveloperPreview.instance.user,
            read: false
        )
    ]
}
