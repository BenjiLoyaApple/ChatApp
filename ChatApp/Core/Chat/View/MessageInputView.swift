//
//  MessageInputView.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI
import PhotosUI

struct MessageInputView: View {
    @Binding var messageText: String
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                if let image = viewModel.messageImage {
                    ZStack(alignment: .topTrailing) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .frame(width: 80, height: 100)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                            )
                        
                        CustomChatButton(
                            imageName: "xmark.circle.fill",
                            font: .callout,
                            foregroundStyle: .gray.opacity(0.8),
                            padding: 5,
                            onButtonPressed: {
                                viewModel.messageImage = nil
                            }
                        )
                    }
                    .padding(8)
                    
                    Spacer()
                } else {
                    if messageText.isEmpty {
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.title3)
                                .foregroundStyle(.gray)
                                .padding(5)
                                .background(Color.black.opacity(0.001))
                                .clipShape(Circle())
                        }
                    }
                    
                    TextField("Message...", text: $messageText, axis: .vertical)
                        .padding(12)
                        .padding(.leading, 4)
                        .padding(.trailing, 48)
                        .background(Color.theme.secondaryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.subheadline)
                }
            }
            
            CustomChatButton(
                imageName: "paperplane",
                font: .title3,
                foregroundStyle: .primary,
                padding: 10,
                onButtonPressed: {
                    Task {
                        try await viewModel.sendMessage(messageText)
                        messageText = ""
                    }
                }
            )
            

        }
        .overlay {
            if viewModel.messageImage != nil {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray4), lineWidth: 0.7)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(messageText: .constant(""),
                         viewModel: ChatViewModel(user: .mock))
    }
}
