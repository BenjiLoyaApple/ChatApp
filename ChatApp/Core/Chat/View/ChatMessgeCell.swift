//
//  ChatMessgeCell.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import Firebase

struct ChatMessageCell: View {
    let message: Message
    var nextMessage: Message?
    
    init(message: Message, nextMessage: Message?) {
        self.message = message
        self.nextMessage = nextMessage
    }
    
    private var shouldShowChatPartnerImage: Bool {
        if nextMessage == nil && !message.isFromCurrentUser { return true }
        guard let next = nextMessage else { return message.isFromCurrentUser }
        return next.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                switch message.contentType {
                    // Отправленные
                case .image(let imageUrl):
                    MessageImageView(imageUrlString: imageUrl)
                        .padding(.horizontal)
                case .text(let messageText):
                    Text(messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(LinearGradient(colors: [
                            .theme.primaryBlue,
                            .blue.opacity(0.9)
                        ], startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .clipShape(ChatBubble(isFromCurrentUser: true, shouldRoundAllCorners: false))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                        .padding(.horizontal)
                case .link(let linkMetaData):
                    LinkPreviewCell(linkMetaData: linkMetaData)
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                        .padding(.horizontal)
                }
            } else {
                // Полученные
                HStack(alignment: .bottom, spacing: 8) {
                    if shouldShowChatPartnerImage {
                        CircularProfileImageView(user: message.user, size: .small28)
                    }
                    
                    switch message.contentType {
                    case .image(let imageUrl):
                        MessageImageView(imageUrlString: imageUrl)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                    case .text(let messageText):
                        Text(messageText)
                            .font(.subheadline)
                            .padding(12)
                            .background(LinearGradient(colors: [
                                .theme.primaryGray2,
                                .theme.primaryGray,
                            ], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(Color.theme.primaryText)
                            .clipShape(ChatBubble(isFromCurrentUser: false, shouldRoundAllCorners: !shouldShowChatPartnerImage))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                        
                    case .link(let linkMetaData):
                                          LinkPreviewCell(linkMetaData: linkMetaData)
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 45)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct ChatMessageCell_Previews: PreviewProvider {
    static var previews: some View {
        let messages = DeveloperPreview.shared.messages
        
        VStack(spacing: 20) {
            ChatMessageCell(message: messages[0], nextMessage: messages[1])
                .previewLayout(.sizeThatFits)
            
            ChatMessageCell(message: messages[1], nextMessage: nil)
                .previewLayout(.sizeThatFits)
        }
    }
}
