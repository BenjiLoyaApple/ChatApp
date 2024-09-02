//
//  ProfileView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import PhotosUI
import SwiftfulRouting

struct ProfileView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ProfileViewModel()
    
    let user: User
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            Spacer()
            
            UserView()
                .padding()
                .task {
                    viewModel.loadUserData()
                }
            
            Spacer()
            
            Text("Settings")
                .onTapGesture {
                    router.showScreen(.fullScreenCover) { _ in
                        SettingsView()
                    }
                }
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
    }
    
    // MARK: - Header
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Button("Cancel") {
                    router.dismissScreen()
                    Task {
                        try? await viewModel.loadCurrentUser()
                    }
                }
                .font(.subheadline)
                .foregroundColor(Color.theme.primaryText)
                
                Spacer(minLength: 0)
                
                Text(viewModel.username)
                    .offset(x: -5)
                
                Spacer(minLength: 0)
                
                Button("Done") {
                    router.dismissScreen()
                    Task {
                        try await viewModel.updateUserData()
                        try? await viewModel.loadCurrentUser()
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.primaryText)
                
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
            
            Divider()
                .offset(y: 10)
        }
        .padding(.vertical)
    }
    
    // MARK: - User
    @ViewBuilder
    private func UserView() -> some View {
        VStack(alignment: .leading, spacing: 11) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.semibold)
                    
                    TextField("username", text: $viewModel.username)
                        .onChange(of: viewModel.username) { _, newValue in
                            if newValue.count > 20 {
                                viewModel.username = String(newValue.prefix(20))
                            }
                        }
                }
                .font(.footnote)
                
                Spacer()
                
                PhotosPicker(selection: $viewModel.selectedImage, matching: .images) {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: ProfileImageSize.small.dimension, height: ProfileImageSize.small.dimension)
                            .clipShape(Circle())
                            .foregroundColor(Color(.systemGray4))
                    } else {
                        CircularProfileImageView(user: user, size: .small)
                    }
                }
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Bio")
                    .fontWeight(.semibold)
                
                TextField("Enter you bio..", text: $viewModel.bio, axis: .vertical)
            }
            .font(.footnote)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Link")
                    .fontWeight(.semibold)
                
                TextField("Add link...", text: $viewModel.link)
            }
            .font(.footnote)
            
            Divider()
        }
        .padding()
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 0.5)
        }
    }
    
    
}

extension User {
    static var mock: User {
        return User(
            userId: "mockUserID",
            username: "benjiloya",
            fullname: "Benji Loya",
            email: "mockuser@example.com",
            profileImageUrl: "https://example.com/mockProfileImage.png",
            bio: "This is a mock user for preview purposes.",
            link: "https://apple.com"
        )
    }
}

#Preview {
    RouterView { _ in
        ProfileView(user: .mock)
    }
}
