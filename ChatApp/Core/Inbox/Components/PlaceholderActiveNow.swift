//
//  PlaceholderActiveNow.swift
//  ChatApp
//
//  Created by Benji Loya on 05.09.2024.
//

import SwiftUI

struct PlaceholderActiveNow: View {
    var body: some View {
        VStack(spacing: 10) {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.gray.opacity(0.25))
                
                Text("user name")
                .font(.callout)
        }
    }
}

#Preview {
    PlaceholderActiveNow()
}
