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

    @State private var showPhotoPicker: Bool = false
    
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
                    TextField("Message...", text: $messageText, axis: .vertical)
                        .padding(12)
                        .padding(.leading, 4)
                        .padding(.trailing, 48)
                        .background(Color.theme.secondaryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.subheadline)
                }
            }

            Button {
                if messageText.isEmpty && viewModel.messageImage == nil {
                    // Открываем фото пикер
                    showPhotoPicker.toggle()
                } else {
                    // Отправляем сообщение
                    Task {
                        await viewModel.sendMessageAndClearState(messageText)
                        messageText = ""
                    }
                }
            } label: {
                MorphingSymbolView(
                    symbol: messageText.isEmpty && viewModel.messageImage == nil ? "photo.on.rectangle" : "paperplane.fill",
                    config: .init(
                        font: .title2,
                        frame: .init(width: 50, height: 50),
                        radius: 2,
                        foregroudColor: .primary,
                        keyFrameDuration: 0.3,
                        symbolAnimation: .smooth(duration: 0.3, extraBounce: 0)
                    )
                )
                .background(Color.clear)
                .clipShape(.circle)
            } 
        }
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: Binding<[PhotosPickerItem]>(
                get: {
                    viewModel.selectedItem.map { [$0] } ?? []
                },
                set: { newValue in
                    viewModel.selectedItem = newValue.first
                }
            ),
            maxSelectionCount: 1,
            selectionBehavior: .ordered
        )
        .overlay {
            if viewModel.messageImage != nil {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray4), lineWidth: 0.7)
            }
        }
        .padding(.horizontal, 10)
       // .padding(.bottom, 8)
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(messageText: .constant(""),
                         viewModel: ChatViewModel(user: .mock))
    }
}
