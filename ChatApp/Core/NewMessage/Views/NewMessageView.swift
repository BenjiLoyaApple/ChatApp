//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct NewMessageView: View {
    @Environment(\.router) var router
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            Divider()
            
        ScrollView {
            TextField("To: ", text: $viewModel.searchText)
                .frame(height: 44)
                .padding(.leading)
                .background(Color.gray.opacity(0.1))
            
            Text("CONTACTS")
                .foregroundColor(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            LazyVStack {
                ForEach(viewModel.filteredUsers) { user in
                        HStack(spacing: 15) {
                            CircularProfileImageView(user: user, size: .medium)
                            
                            Text(user.username)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.vertical, 2)
                        .onTapGesture {
                            selectedUser = user
                            router.showScreen(.push) { _ in
                                ChatView(user: user)
                            }
                        }
                    .padding(.leading)
                }
            }
        }
    }
        .background(Color.theme.darkBlack)
        
    }
    
    // Header
    private var header: some View {
        HStack(spacing: 0) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            
            Spacer(minLength: 0)
        }
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity)
        .padding(20)
        .overlay(
            Text("New Message")
                .fontWeight(.semibold)
        )
    }
    
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(selectedUser: .constant(nil))
    }
}




/*
 import SwiftUI
 import SwiftfulRouting

 struct NewMessageView: View {
     @Environment(\.router) var router
     @Environment(\.dismiss) var dismiss
     @StateObject var viewModel = NewMessageViewModel()
     @Binding var selectedUser: User?
     
     var body: some View {
         NavigationStack {
             ScrollView {
                 TextField("To: ", text: $viewModel.searchText)
                     .frame(height: 44)
                     .padding(.leading)
                     .background(Color.gray.opacity(0.1))
                 
                 Text("CONTACTS")
                     .foregroundColor(.gray)
                     .font(.footnote)
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .padding()
                 
                 LazyVStack {
                     ForEach(viewModel.filteredUsers) { user in
                         VStack {
                             HStack(spacing: 15) {
                                 CircularProfileImageView(user: user, size: .medium)

                                 Text(user.username)
                                     .font(.subheadline)
                                     .fontWeight(.semibold)

                                 Spacer()
                             }
                             .onTapGesture {
                                 dismiss()
                                 selectedUser = user
                             }
                             
                             Divider()
                                 .padding(.leading, 60)
                                 .padding(.trailing)
                         }
                         .padding(.leading)
                     }
                 }
             }
             .navigationTitle("New Message")
             .navigationBarTitleDisplayMode(.inline)
             .toolbar {
                 ToolbarItem(placement: .navigationBarLeading) {
                     Button("Cancel") {
                         dismiss()
                     }
                     .foregroundColor(Color.theme.primaryText)
                 }
             }
         }
         .background(Color.theme.darkBlack)
     }
 }

 struct NewMessageView_Previews: PreviewProvider {
     static var previews: some View {
         NewMessageView(selectedUser: .constant(nil))
     }
 }

 */
