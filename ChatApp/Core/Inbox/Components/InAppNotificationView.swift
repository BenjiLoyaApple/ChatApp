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
    
    @State private var showContent: Bool = false
    
    var body: some View {
        HStack(spacing: 10) {
            /// Иконка профиля отправителя
            if showContent {
                CircularProfileImageView(user: user, size: .small24)
                    .transition(.opacity)
            } else {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black.opacity(0.001))
            }
            
            Text(user.username)
                .font(.caption)
                .foregroundStyle(.white)

            Spacer(minLength: 0)

            if showContent {
                CustomChatButton(
                    imageName: .systemName(iconForMessageType()),
                    font: .system(size: 16),
                    foregroundStyle: Color.theme.appNotification,
                    padding: 0,
                    frame: CGSize(width: 25, height: 25),
                    onButtonPressed: {
                        // нажатие кнопки
                    }
                )
                .transition(.opacity)
            }  else {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black.opacity(0.001))
            }
        }
        .padding(.bottom, 1)
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
        }
        .frame(maxWidth: 200)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.53) {
                withAnimation(.smooth(duration: 0.5)) {
                    showContent = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.85) {
                withAnimation(.smooth(duration: 0.5)) {
                    showContent = false
                }
            }
        }
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
