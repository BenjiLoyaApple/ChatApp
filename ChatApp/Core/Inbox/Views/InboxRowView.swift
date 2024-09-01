//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct InboxRowView: View {
    @Environment(\.router) var router
    @ObservedObject var viewModel: InboxViewModel
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
                CircularProfileImageView(user: message.user, size: .small)
            
                VStack(alignment: .leading, spacing: 6) {
                    if let user = message.user {
                        Text(user.username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.primaryText)
                    }
                    
                    Text("\(message.isFromCurrentUser ? "You: \(message.text)" : message.text)")
                      //  .font(.footnote)
                        .font(.system(size: 13, weight: .light, design: .default))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                }
            VStack(spacing: 20) {
                HStack {
                    Text(message.timestamp.timestampString())
                        .font(.system(size: 11, weight: .light, design: .default))
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.trailing, 5)
                
                if !message.read && !message.isFromCurrentUser {
                    Circle()
                        .fill(Color.theme.primaryBlue)
                        .frame(width: 6, height: 6, alignment: .leading)
                }
            }

        }
        .frame(maxHeight: 72)
//        .swipeActions(content: {
//            withAnimation(.spring()) {
//                Button {
//                    Task { try await viewModel.deleteMessage(message) }
//                } label: {
//                    Image(systemName: "trash")
//                }
//                .tint(Color(.systemRed))
//            }
//        })
    }
}


//#Preview {
//    RouterView { _ in
//        InboxRowView(viewModel: InboxViewModel(), message: dev.messages[0])
//    }
//}
