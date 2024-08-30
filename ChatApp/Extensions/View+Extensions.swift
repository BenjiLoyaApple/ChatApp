//
//  View+Extensions.swift
//
//  Created by Benji Loya on 14/12/2022.
//

import SwiftUI

///   MARK: View Extension For UI Building
extension View {
    
    //   MARK: - Closing all Active Keyboards
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //     MARK: - Disabling with Opacity
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ aligment: Alignment)->some View {
        self
            .frame(maxWidth: .infinity, alignment: aligment)
    }
    func vAlign(_ aligment: Alignment)->some View {
        self
            .frame(maxHeight: .infinity, alignment: aligment)
    }
    
    //    MARK: - Custom Border View With Padding
    func border(_ width: CGFloat,_ color: Color)->some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
}


//MARK: - LOGIN SHEET
extension View {
    @ViewBuilder
    func heightChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: SizeKey.self, value: geometry.size.height)
                        .onPreferenceChange(SizeKey.self, perform: { value in
                            completion(value)
                        })
                })
            }
    }
}

extension View {
    @ViewBuilder
    func minXChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: OffsetKeyLogin.self, value: geometry.frame(in: .scrollView).minX)
                        .onPreferenceChange(OffsetKeyLogin.self, perform: { value in
                            completion(value)
                        })
                })
            }
    }
}
