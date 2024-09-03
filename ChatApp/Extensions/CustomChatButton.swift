//
//  CustomButton.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI

struct CustomChatButton: View {
    
    var imageName: String?
    var font: Font? = .title3
    var foregroundStyle: Color? = .primary
    var padding: CGFloat? = 10
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onButtonPressed?()
        }) {
            Image(systemName: imageName ?? "")
                .font(font)
                .foregroundStyle(foregroundStyle ?? .primary)
                .padding(padding ?? 10)
                .background(Color.black.opacity(0.001))
                .clipShape(Circle())
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
            imageName: "gamecontroller",
            foregroundStyle: .purple
        )
    }
    .padding(.horizontal)
}
