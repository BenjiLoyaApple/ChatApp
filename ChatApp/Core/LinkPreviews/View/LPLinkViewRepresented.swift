//
//  LPLinkViewRepresented.swift
//  ChatApp
//
//  Created by Benji Loya on 16.08.2023.
//

import LinkPresentation
import SwiftUI

class CustomLinkView: LPLinkView {
    override var intrinsicContentSize: CGSize { CGSize(width: 0, height: super.intrinsicContentSize.height) }
}

struct LPLinkViewRepresented: UIViewRepresentable {
    typealias UIViewType = CustomLinkView
    var metadata: LPLinkMetadata
    
    func makeUIView(context: Context) -> CustomLinkView {
        let linkView = CustomLinkView(metadata: metadata)
        return linkView
    }
    
    func updateUIView(_ uiView: CustomLinkView, context: Context) {}
}
