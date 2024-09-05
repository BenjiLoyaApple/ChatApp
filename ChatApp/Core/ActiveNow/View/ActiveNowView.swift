//
//  ActiveNowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct ActiveNowView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                if viewModel.isLoading {
                    ForEach(0..<10) { _ in
                        PlaceholderActiveNow()
                            .redacted(reason: .placeholder)
                            .shimmer(.init(tint: Color.theme.buttonsPostCard.opacity(0.4), highlight: .gray, blur: 5))
                    }
                } else {
                    ForEach(viewModel.users) { user in
                            VStack {
                                ZStack(alignment: .bottomTrailing) {
                                    CircularProfileImageView(user: user, size: .large60)
                                        .onTapGesture {
                                            router.showScreen(.push) { _ in
                                            ChatView(user: user)
                                        }
                                    }
                                    ZStack {
                                        Circle()
                                            .fill(Color.theme.background)
                                            .frame(width: 12, height: 12)

                                        Circle()
                                            .fill(.green)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                                
                                Text(user.username)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        
                    }
                }
                
                
            }
        }
    }
}

struct ActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNowView()
    }
}
