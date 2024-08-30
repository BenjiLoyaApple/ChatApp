//
//  MSGButtonModifier.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI

struct MSGButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(Color(.systemBlue))
            .cornerRadius(8)
    }
}
