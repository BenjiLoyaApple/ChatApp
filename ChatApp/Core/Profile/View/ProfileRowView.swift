//
//  ProfileRowView.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI

struct ProfileRowView: View {
    let viewModel: SettingsOptionsViewModel
        
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.theme.background, viewModel.imageBackgroundColor)
            
            Text(viewModel.title)
                .font(.subheadline)
        }
    }
}

struct ProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRowView(viewModel: .accessibility)
    }
}
