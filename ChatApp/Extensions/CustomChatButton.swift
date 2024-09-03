//
//  CustomButton.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI

struct CustomChatButton: View {
    var imageName: String?
    var text: String?
    var font: Font? = .title3
    var foregroundStyle: Color? = .primary
    var padding: CGFloat? = 10
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onButtonPressed?()
        }) {
            Group {
                if let imageName = imageName, !imageName.isEmpty {
                    Image(systemName: imageName)
                } else if let text = text, !text.isEmpty {
                    Text(text)
                }
            }
            .font(font)
            .foregroundStyle(foregroundStyle ?? .primary)
            .padding(padding ?? 10)
            .background(Color.black.opacity(0.001))
            .clipShape(Capsule())
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomChatButton(
            imageName: "bell"
        )
        
        CustomChatButton(
            imageName: "moon",
            font: .title,
            foregroundStyle: .teal,
            padding: 20
        )
        
        CustomChatButton(
            text: "Done",
            foregroundStyle: .purple
        )
    }
    .padding(.horizontal)
}
