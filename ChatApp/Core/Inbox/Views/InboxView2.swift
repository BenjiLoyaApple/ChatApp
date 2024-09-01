//
//  InboxView2.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

/*
import SwiftUI

struct InboxView2: View {
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack {
                List {
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.bottom)
                        .padding(.leading, 8)
                        .padding(.top, 5)
                    
                    HStack {
                        Text("Recent Chat")
                            .font(.system(size: 18, weight: .semibold, design: .default))
                    }
                    
                    ForEach(viewModel.filteredMessages) { recentMessage in
                        ZStack {
                            NavigationLink(value: recentMessage) {
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(message: recentMessage, viewModel: viewModel)
                                .onAppear {
                                    if recentMessage == viewModel.recentMessages.last {
                                        print("DEBUG: Paginate here..")
                                    }
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 10)
                }
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search")
                .listStyle(PlainListStyle())
                .onChange(of: selectedUser, perform: { newValue in
                    showChat = newValue != nil
                })
                .fullScreenCover(isPresented: $showNewMessageView, content: {
                    NewMessageView(selectedUser: $selectedUser)
                })
                .navigationDestination(for: Message.self, destination: { message in
                    if let user = message.user {
                        ChatView(user: user)
                    }
                })
                .navigationDestination(isPresented: $showChat, destination: {
                    if let user = selectedUser {
                        ChatView(user: user)
                    }
                })
                .navigationDestination(isPresented: $showProfile, destination: {
                    if let user = viewModel.user {
                        ProfileView(user: user)
                    }
                })
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .profile(let user):
                        ProfileView(user: user)
                    case .chatView(let user):
                        ChatView(user: user)
                    }
                })
                .overlay { if !viewModel.didCompleteInitialLoad { ProgressView() } }
                .navigationTitle("Chats")
                // .navigationBarTitleDisplayMode(.inline)
                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                            if let user = viewModel.user {
//                                CircularProfileImageView(user: user, size: .xSmall)
//                                    .onTapGesture { showProfile.toggle() }
//                            }
//                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        if let user = viewModel.user {
                            HStack {
                                CircularProfileImageView(user: user, size: .xSmall)
                                    
                                Text(user.username)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                            }
                            .onTapGesture { showProfile.toggle() }
                        }
                    }

                    
                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Image(systemName: "square.and.pencil.circle.fill")
//                            .resizable()
//                            .frame(width: 28, height: 28)
                        Image("edit")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray)
                            .foregroundStyle(Color.theme.primaryText, Color(.systemGray5))
                            .onTapGesture {
                                showNewMessageView.toggle()
                                selectedUser = nil
                            }
                    }
                }
            
        }
    }
}

struct InboxView2_Previews: PreviewProvider {
    static var previews: some View {
        InboxView2()
    }
}

*/
