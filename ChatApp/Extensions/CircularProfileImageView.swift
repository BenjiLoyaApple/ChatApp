//
//  CircularProfileImageView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI

enum ProfileImageSize {
    case xxxLSmall
    case xxxSmall
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxxLSmall: return 14
        case .xxxSmall: return 22
        case .xxSmall: return 28
        case .xSmall: return 34
        case .small: return 40
        case .medium: return 46
        case .large: return 54
        case .xLarge: return 60
        }
    }
    
    var fontSize: CGFloat {
          switch self {
          case .xxxLSmall: return 7
          case .xxxSmall: return 11
          case .xxSmall: return 14
          case .xSmall: return 17
          case .small: return 20
          case .medium: return 23
          case .large: return 27
          case .xLarge: return 30
          }
      }
    
}

enum ProfileBackgroundColor: CaseIterable {
    case red, blue, green, orange, purple, yellow, pink, teal
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        case .orange: return Color.orange
        case .purple: return Color.purple
        case .yellow: return Color.yellow
        case .pink: return Color.pink
        case .teal: return Color.teal
        }
    }
}

struct UserInitialsView: View {
    let fullname: String
    let fontSize: CGFloat
    
    private var initials: String {
        let names = fullname.split(separator: " ")
        let firstInitial = names.first?.first?.uppercased() ?? ""
        let lastInitial = names.count > 1 ? names.last?.first?.uppercased() ?? "" : ""
        return "\(firstInitial)\(lastInitial)"
    }
    
    private var backgroundColor: Color {
            ProfileBackgroundColor.allCases.randomElement()?.color ?? Color.gray
        }
    
    var body: some View {
        Text(initials)
            .font(.system(size: fontSize, weight: .semibold))
            .frame(width: fontSize * 2, height: fontSize * 2)
            .background(backgroundColor.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

// View
struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            WebImage(url: URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color(.systemGray4), lineWidth: 0.5)
                }
        } else {
            UserInitialsView(fullname: user?.fullname ?? "User", fontSize: size.fontSize)
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}

//struct CircularProfileImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProfileImageView(user: dev.user, size: .large)
//    }
//}
