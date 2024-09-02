//
//  InboxView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct InboxView: View {
    @Environment(\.router) var router
    
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    
  //  @State private var showNewMessageView = false
    @State private var showChat = false
    @State private var showProfile = false
    
    // MARK: View Properties
    @State private var headerHeight: CGFloat = 0
    @State private var headerOffset: CGFloat = 0
    @State private var lastHeaderOffset: CGFloat = 0
    @State private var direction: SwipeDirection = .none
    /// MARK: Shift Offset Means The Value From Where It Shifted From Up/Down
    @State private var shiftOffset: CGFloat = 0
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.clear)
                    .frame(width: 200, height: 1)
                    .padding(.top, headerHeight)
                    .offsetY { previous, current in
                        // MARK: Moving Header Based On Direction Scroll
                        if previous > current {
                            // MARK: Up
                            // print("Up")
                            if direction != .up && current < 0 {
                                shiftOffset = current - headerOffset
                                direction = .up
                                lastHeaderOffset = headerOffset
                            }
                            
                            let offset = current < 0 ? (current - shiftOffset) : 0
                            // MARK: Checking If It Does Not Go Over Header Height
                            headerOffset = (-offset < headerHeight ? (offset < 0 ? offset : 0) : -headerHeight)
                        } else {
                            // MARK: Down
                            // print("Down")
                            if direction != .down {
                                shiftOffset = current
                                direction = .down
                                lastHeaderOffset = headerOffset
                            }
                            
                            let offset = lastHeaderOffset + (current - shiftOffset)
                            headerOffset = (offset > 0 ? 0 : offset)
                        }
                    }
                    
                    ActiveNowView()
                        .padding(.bottom)
                        .padding(.horizontal)
                        .onTapGesture {
                            if let user = selectedUser {
                                router.showScreen(.push) { _ in
                                    ChatView(user: user)
                                }
                            }
                        }
                        
                    
                    HStack {
                        Text("Recent Chat")
                            .font(.title3.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                ChatsView()
                
            }
            .background(Color.theme.darkBlack)
            .coordinateSpace(name: "SCROLL")
            .overlay(alignment: .top) {
                // Header
                InboxHeader(
                    headerHeight: $headerHeight, headerOffset: $headerOffset, profileImage: CircularProfileImageView(user: viewModel.user, size: .small), username: viewModel.user?.username ?? "",
                    profileimageTapped: {
                        router.showScreen(.push) { _ in
                            if let user = viewModel.user {
                                ProfileView(user: user)
                            }
                        }
                    },
                    searchTapped: {
                        
                    },
                    newChatTapped: {
                        router.showScreen(.fullScreenCover) { _ in
                            NewMessageView(selectedUser: $selectedUser)
                        }
                        selectedUser = nil
                    }
                )
                    .task {
                  //      vm.loadUserData()
                    }
            }
            .refreshable {}
            // MARK: Due To Safe Area
            .ignoresSafeArea(.all, edges: .top)
    }
    
    @ViewBuilder
    func ChatsView() -> some View {
            LazyVStack {
                if !viewModel.didCompleteInitialLoad {
                    ForEach(0..<10) { _ in
                        PlaceholderFeedView()
                            .redacted(reason: .placeholder)
                            .shimmer(.init(tint: Color.theme.buttonsPostCard.opacity(0.6), highlight: .gray, blur: 5))
                    }
                } else {
                    ForEach(viewModel.filteredMessages) { recentMessage in
                        if let user = recentMessage.user {
                            MessageCell(
                                //     viewModel: viewModel,
                                message: recentMessage,
                                profileImage: CircularProfileImageView(user: user, size: .small),
                                username: user.username,
                                timestamp: recentMessage.timestamp.timestampString(),
                                textMessage: recentMessage.text,
                                actionButtonTapped: {
                                    Task { try await viewModel.deleteMessage(recentMessage) }
                                },
                                showChatTapped: {
                                    router.showScreen(.push) { _ in
                                        if let user = recentMessage.user {
                                            ChatView(user: user)
                                            
                                        }
                                    }
                                }
                            )
                            .padding(.horizontal, 10)
                            .onAppear {
                                if recentMessage == viewModel.recentMessages.last {
                                    print("DEBUG: Paginate here..")
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 20)
    }
}

#Preview {
    RouterView { _ in
        InboxView()
    }
}
