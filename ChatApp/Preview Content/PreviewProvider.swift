//
//  PreviewProvider.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI
import Firebase
import LinkPresentation

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    // Моковый пользователь
       var user: User {
           User(
               userId: "12345",
               username: "benjiloya",
               fullname: "Benji Loya",
               email: "batman@gmail.com",
               profileImageUrl: nil,
               bio: "Just a superhero in disguise.",
               link: "https://batman.com"
           )
       }
       
       // Массив моковых сообщений
    var messages: [Message] {
        [
            Message(
                messageId: "1",
                fromId: "12345",
                toId: "67890",
                caption: "Hello! This is a test message.",
                timestamp: Timestamp(),
                user: user,
                read: false,
                imageUrl: nil
            ),
            Message(
                messageId: "2",
                fromId: "67890",
                toId: "12345",
                caption: "Hi! Here's another test message.\nstring test message.",
                timestamp: Timestamp(),
                user: user,
                read: true,
                imageUrl: nil
            )
        ]
    }
    
    // Создаем метаданные ссылки
    var linkMetadataWrapper: LinkMetadataWrapper {
        let metadata = LPLinkMetadata()
        metadata.title = "Apple"
        metadata.originalURL = URL(string: "https://www.apple.com/iphone/")
        
        // Создаем данные изображения для метаданных ссылки
        let imageData = try? Data(contentsOf: URL(string: "https://www.apple.com/ac/structured-data/images/open_graph_logo.png?202110180743")!)
        
        // Оборачиваем метаданные ссылки
        return LinkMetadataWrapper(metadata: metadata, imageData: imageData)
    }
    
    lazy var imageUrlString =  "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
    
}
