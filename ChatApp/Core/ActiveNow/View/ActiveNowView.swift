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
            HStack(spacing: 20) {
                ForEach(viewModel.users) { user in
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                CircularProfileImageView(user: user, size: .medium)
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

struct ActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNowView()
    }
}
