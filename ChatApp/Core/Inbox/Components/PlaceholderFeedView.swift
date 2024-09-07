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
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.gray.opacity(0.25))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .top, spacing: 10) {
                        Text("user name")
                           // .textScale(.secondary)
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
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
        .padding(.bottom, 20)
    }
}

#Preview {
    VStack {
        PlaceholderFeedView()
        PlaceholderFeedView()
        PlaceholderFeedView()
        PlaceholderFeedView()
        PlaceholderFeedView()
    }
}
