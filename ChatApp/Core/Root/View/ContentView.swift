//
//  ContentView.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                InboxView()
            } else {
                IntrosView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
