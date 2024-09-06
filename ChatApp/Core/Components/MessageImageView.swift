//
//  MessageImageView.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageImageView: View {
    let imageUrlString: String
    
    var body: some View {
        WebImage(url: URL(string: imageUrlString))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 360)
                .clipShape(Rectangle())
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                )
                .padding(.horizontal, 10)
    }
}

#Preview {
    MessageImageView(imageUrlString: "https://259506.selcdn.ru/sites-static/site701987/563a7e6f-ba06-4394-bca5-eafcc0f55652/563a7e6f-ba06-4394-bca5-eafcc0f55652-5542720.png")
}






/*
 import SwiftUI
import SDWebImageSwiftUI

struct MessageImageView: View {
    let imageUrlString: String
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            WebImage(url: URL(string: imageUrlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: size.width)
                    .clipShape(Rectangle())
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                    )
            } placeholder: {
                Rectangle()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width)
                    .foregroundColor(.gray.opacity(0.1))
                    .clipShape(Rectangle())
                    .cornerRadius(14)
            }
            .indicator(.progress(style: CustomProgressIndicatorStyle()))
            .transition(.fade(duration: 0.25))
            .contentShape(Rectangle())
        }
        .frame(height: CGFloat(300))
    }
}

#Preview {
    MessageImageView(imageUrlString: "https://259506.selcdn.ru/sites-static/site701987/563a7e6f-ba06-4394-bca5-eafcc0f55652/563a7e6f-ba06-4394-bca5-eafcc0f55652-5542720.png")
        .padding()
}
 */
