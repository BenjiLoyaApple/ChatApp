//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import Foundation
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
        
    @MainActor
    func loadImage() async throws {
        guard let uiImage = try await PhotosPickerHelper.loadImage(fromItem: selectedItem) else { return }
        profileImage = Image(uiImage: uiImage)
        try await updateUserProfileImage(uiImage)
    }
    
    func updateUserProfileImage(_ uiImage: UIImage) async throws {
        guard let imageUrl = try? await ImageUploader.uploadImage(image: uiImage, type: .profile) else { return }
        try await UserService.shared.updateUserProfileImageUrl(imageUrl)
    }
    
    
}
