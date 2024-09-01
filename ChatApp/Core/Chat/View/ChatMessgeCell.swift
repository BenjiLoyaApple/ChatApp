//
//  ChatMessgeCell.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

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
                case .image(let imageUrl):
                    MessageImageView(imageUrlString: imageUrl)
                case .text(let messageText):
                    Text(messageText)
                        .font(.subheadline)
                        .padding(12)
                      //  .background(Color.theme.primaryBlue)
                        .background(LinearGradient(colors: [
                            .theme.primaryBlue,
                            .blue.opacity(0.9)
                        ], startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .clipShape(ChatBubble(isFromCurrentUser: true, shouldRoundAllCorners: false))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                        .padding(.horizontal)
                case .link(let urlString):
                    LinkPreview(urlString: urlString)
                        .padding(.horizontal)
                }
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    if shouldShowChatPartnerImage {
                        CircularProfileImageView(user: message.user, size: .xxSmall)
                    }
                    
                    switch message.contentType {
                    case .image(let imageUrl):
                        MessageImageView(imageUrlString: imageUrl)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                    case .text(let messageText):
                        Text(messageText)
                            .font(.subheadline)
                            .padding(12)
                           // .background(Color(.systemGray6))
                            .background(LinearGradient(colors: [
                                .theme.primaryGray2,
                                .theme.primaryGray,
                            ], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(Color.theme.primaryText)
                            .clipShape(ChatBubble(isFromCurrentUser: false, shouldRoundAllCorners: !shouldShowChatPartnerImage))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                            .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                        
                    case .link(let urlString):
                        LinkPreview(urlString: urlString)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct MessageImageView: View {
    let imageUrlString: String
    
    var body: some View {
        WebImage(url: URL(string: imageUrlString))
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 400)
            .cornerRadius(10)
            .padding(.trailing)
    }
}

struct ChatMessageCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageCell(message: dev.messages[0], nextMessage: dev.messages[1])
    }
}
