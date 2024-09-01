//
//  Test.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

import SwiftUI

struct MessCell<ProfileImageView: View>: View {
        
    let profileImage: ProfileImageView
    let username: String
    let timestamp: String
    let textMessage: String?
    var actionButtonTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            // Отображение переданного изображения
            profileImage
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .top, spacing: 10) {
                    // имя юзера
                        Text(username)
                            .textScale(.secondary)
                            .fontWeight(.semibold)
                    
                    // Дата
                    Text(timestamp)
                        .textScale(.secondary)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary.opacity(0.7))
                    
                    // прочнено - или нет
                        Circle()
                            .fill(Color.theme.primaryBlue)
                            .frame(width: 6, height: 6)
                            .offset(y: 9)
                    
                    
                    Spacer(minLength: 0)
                    
                        Button {
                            actionButtonTapped?()
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray)
                                .padding(15)
                                .background(Color.black.opacity(0.001))
                                .clipShape(Circle())
                        }
                        .offset(x: 8, y: -5)
                    
                }
                
                // Текст сообщения
                Text(textMessage ?? "")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .offset(y: -14)
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
            .offset(y: -2)
        }

    }
}

#Preview {
    // Используем подставные данные для превью
    MessCell(
        profileImage: Image(systemName: "person.crop.circle").resizable().frame(width: 40, height: 40),
        username: "benjiloya",
        timestamp: "10 min",
        textMessage: "Hello, this is the first test message.  Hello, this is the first test message.  Hello, this is the first test message.",
        actionButtonTapped: {
            print("Action button tapped")
        }
    )
    .padding()
    .previewLayout(.sizeThatFits)
}
