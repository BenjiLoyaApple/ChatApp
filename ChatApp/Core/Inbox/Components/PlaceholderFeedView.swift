//
//  Place.swift
//  SocialCloud
//
//  Created by Benji Loya on 05.05.2024.
//

import SwiftUI

struct PlaceholderFeedView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 6) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.gray.opacity(0.25))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .top, spacing: 10) {
                        Text("user name")
                           // .textScale(.secondary)
                            .fontWeight(.semibold)
                        
                        Text("2w")
                            .textScale(.secondary)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "ellipsis")
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("The first post title here")
                        
                        Text("The first post description here")
                    }
                    .font(.system(size: 15))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.bottom, 50)
    }
}

#Preview {
    PlaceholderFeedView()
}
