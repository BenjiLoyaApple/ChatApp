//
//  SizeKey.swift
//  SheetHeight
//
//  Created by Benji Loya on 08.08.2024.
//

import SwiftUI

struct SizeKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
