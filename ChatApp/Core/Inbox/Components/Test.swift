//
//  Test.swift
//  ChatApp
//
//  Created by Benji Loya on 05.09.2024.
//

import SwiftUI

struct Test: View {
    
    var body: some View {
        HStack(spacing: 6) {
            // Отображение переданного изображения
            Circle()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Divider()
                    .offset(y: 18)
                
                HStack(alignment: .center, spacing: 10) {
                    // имя юзера
                        Text("username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    
                    // Дата
                    Text("10 min")
                        .textScale(.secondary)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary.opacity(0.7))
                    
                    // прочнено - или нет
                        Circle()
                            .fill(Color.theme.primaryBlue)
                            .frame(width: 6, height: 6)
                        //    .offset(y: 9)
                    
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                        .padding(15)
                        .background(Color.black.opacity(0.001))
                        .clipShape(Circle())
                        .asButton(.press) {
                  //          actionButtonTapped?()
                        }
                }
                
                Rectangle()
                    .frame(width: 250, height:38)
                    .foregroundStyle(.black.opacity(0.001))
                    .overlay {
                        // Текст сообщения
                        VStack (spacing: 2) {
                            Text("Hello \nHow are you?")
                            
                            Spacer(minLength: 0)
                        }
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.001))
                        .asButton(.press) {
                            // showChatTapped?()
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

#Preview {
    VStack {
        Test()
        Test()
        Test()
    }
    .padding(.horizontal)
}
