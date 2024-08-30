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
    
    let user = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: nil)
    
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
