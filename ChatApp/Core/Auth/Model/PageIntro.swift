//
//  PageIntro.swift
//  NewForSwiftUI
//
//  Created by Benji Loya on 03/04/2023.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var tittle: String
    var subTittle: String
    var displayysAction : Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "Pic 1", tittle: "Connect With\nFriends Easilly", subTittle: "Thank you for choosing us"),
   // .init(introAssetImage: "Pic 2", tittle: "Get Inspiratin\nFrom Creators", subTittle: "Find u favourite creator"),
    .init(introAssetImage: "Pic 3", tittle: "Let's\nGet Started", subTittle: "to register for an account, enter your details", displayysAction: true),
]
