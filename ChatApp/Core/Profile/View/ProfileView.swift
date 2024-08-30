//
//  ProfileView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    let user: User
    @StateObject var viewModel = ProfileViewModel()
    
    
    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    ZStack(alignment: .bottomTrailing) {
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: ProfileImageSize.xLarge.dimension, height: ProfileImageSize.xLarge.dimension)
                                .clipShape(Circle())
                        } else {
                            CircularProfileImageView(user: user, size: .xLarge)
                        }
                        
                        ZStack {
                            Circle()
                                .fill(Color.theme.background)
                                .frame(width: 24, height: 24)
                            
                            Image(systemName: "camera.circle.fill")
                                .foregroundStyle(Color.theme.primaryText, Color(.systemGray5))
                                .frame(width: 18, height: 18)
                        }
                    }
                }
                
                Text(user.username)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { viewModel in
                        ProfileRowView(viewModel: viewModel)
                    }
                }
                
                Section {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        AuthService.shared.deleteUser()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                           
                                        }
                    } label: {
                        Text("Delete Account")
                            .foregroundColor(.red)
                    }
                }
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
