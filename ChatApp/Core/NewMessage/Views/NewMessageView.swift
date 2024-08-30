//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI

struct NewMessageView: View {
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

                                Text(user.fullname)
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
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(selectedUser: .constant(nil))
    }
}
