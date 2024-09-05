//
//  PostHeaderView.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

import SwiftUI
import SwiftfulUI

struct InboxCell<ProfileImageView: View>: View {
    
    var message: Message = DeveloperPreview.shared.messages[0]
    
    let profileImage: ProfileImageView
    let username: String
    let timestamp: String
    let textMessage: String?
    var actionButtonTapped: (() -> Void)? = nil
    var showChatTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            // Отображение изображения
            profileImage
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    // имя юзера
                    if let user = message.user {
                        Text(username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    // Дата
                    Text(message.timestamp.timestampString())
                        .textScale(.secondary)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary.opacity(0.7))
                    
                    // прочнено - или нет
                    if !message.read && !message.isFromCurrentUser {
                        Circle()
                            .fill(Color.theme.primaryBlue)
                            .frame(width: 6, height: 6)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                        .padding(15)
                        .background(Color.black.opacity(0.001))
                        .clipShape(Circle())
                        .asButton(.press) {
                            actionButtonTapped?()
                        }
                }
                
                Rectangle()
                    .frame(width: 250, height:38)
                    .foregroundStyle(.black.opacity(0.001))
                    .overlay {
                        // Текст сообщения
                        VStack (spacing: 2) {
                            if let textMessage {
                                Text("\(message.isFromCurrentUser ? "You: \(message.text)" : message.text)")
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.001))
                        .asButton(.press) {
                             showChatTapped?()
                        }
                    }
                
                Divider()
                    .opacity(0.5)
                    .offset(y: 10)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
        }
        .padding(.top, 8)
        
    }
}


struct InboxCell_Previews: PreviewProvider {
    static var previews: some View {
        let messages = DeveloperPreview.shared.messages
        let user = DeveloperPreview.shared.user
        
        return VStack {
            InboxCell(
                message: messages[0],
                profileImage: CircularProfileImageView(user: user, size: .medium50),
                username: user.username,
                timestamp: "2h ago",
                textMessage: messages[0].text
            )
            .previewLayout(.sizeThatFits)
            .padding()
            
            InboxCell(
                message: messages[1],
                profileImage: CircularProfileImageView(user: user, size: .medium50),
                username: user.username,
                timestamp: "1h ago",
                textMessage: messages[1].text
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
