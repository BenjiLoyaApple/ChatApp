//
//  InAppNotificationView.swift
//  ChatApp
//
//  Created by Benji Loya on 19.09.2024.
//

import SwiftUI

struct InAppNotificationView: View {
    let message: Message
    let user: User
    
    var body: some View {
        HStack(spacing: 10) {
            /// Иконка профиля отправителя
            CircularProfileImageView(user: user, size: .small24)
            
            Text(user.username)
                .font(.caption)
                .foregroundStyle(.white)

            Spacer(minLength: 0)

            /// Текст сообщения или иконка чата
            Button(action: {
                // Можно добавить действие при нажатии, например, переход в чат с пользователем
            }, label: {
                Image(systemName: iconForMessageType())
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.appNotification)
                    .padding(.trailing, 5)
            })
        }
        .padding(.bottom, 1)
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
        }
        .frame(maxWidth: 190)
    }
    
    /// Функция для выбора иконки в зависимости от типа сообщения
       private func iconForMessageType() -> String {
           switch message.contentType {
           case .text:
               return "envelope"
           case .image:
               return "photo.on.rectangle.angled"
           case .link:
               return "paperclip"
           }
       }
    
}

#Preview {
    InAppNotificationView(message: DeveloperPreview.shared.messages[0], user: DeveloperPreview.shared.user)
}
