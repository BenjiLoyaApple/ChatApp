//
//  FeedHeader.swift
//  MyThreads
//
//  Created by Benji Loya on 23.07.2024.
//

import SwiftUI
import SwiftfulUI

// MARK: Swipe Direction
enum SwipeDirection {
    case up
    case down
    case none
}

struct InboxHeader<ProfileImageView: View>: View {
  //  var user: User?
    @Binding var headerHeight: CGFloat
    @Binding var headerOffset: CGFloat

    let profileImage: ProfileImageView
    let username: String
    var profileimageTapped: (() -> Void)? = nil
    var searchTapped: (() -> Void)? = nil
    var newChatTapped: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                profileImage
                    .asButton(.press) {
                        profileimageTapped?()
                    }
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(username)
                        .font(.system(size: 23, weight: .semibold, design: .default))
                }
                
                Spacer(minLength: 0)
                
                HStack(spacing: 2) {
                    // Search
                    Button(action: {
                        searchTapped?()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(Color.black.opacity(0.001))
                            .clipShape(Circle())
                    }
                    
                    // New Chat
                    Button(action: {
                        newChatTapped?()
                    }) {
                        Image("edit")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(Color.black.opacity(0.001))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 15)
            
            Divider()
                .offset(y: 10)
                .opacity(0.5)
        }
        .padding(.top, safeArea().top)
        .padding(.bottom, 10)
        .background {
            Color.theme.darkBlack
        }
        .padding(.bottom, 20)
        .anchorPreference(key: HeaderBoundsKey.self, value: .bounds) { $0 }
        .overlayPreferenceValue(HeaderBoundsKey.self) { value in
            GeometryReader { proxy in
                if let anchor = value {
                    Color.clear
                        .onAppear {
                            // MARK: Retrieving Rect Using Proxy
                            headerHeight = proxy[anchor].height
                        }
                }
            }
        }
        .offset(y: -headerOffset < headerHeight ? headerOffset : (headerOffset < 0 ? headerOffset : 0))
    }
}

#Preview {
    InboxView()
}
