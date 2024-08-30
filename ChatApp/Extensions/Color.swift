//
//  Color.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import SwiftUI

extension Color {
    static var theme = Theme()
}

struct Theme {
    let primaryText = Color("PrimaryTextColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackground")
    
    let primaryBlue = Color("PrimaryBlue")
    let primaryGray = Color("PrimaryGray")
    let primaryGray2 = Color("PrimaryGray2")
}
