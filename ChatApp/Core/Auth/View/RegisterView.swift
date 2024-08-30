//
//  RegisterView.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
            VStack {
                
                Spacer()
                
                // logo image
                Image("messenger-app-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                // text fields
                VStack {
                    
                    CustomTextField(text: $viewModel.fullname, hint: "Username", leadingIcon: Image(systemName: "person"))
                        .submitLabel(.next)
                    
                    CustomTextField(text: $viewModel.email, hint: "Email", leadingIcon: Image(systemName: "envelope"))
                        .submitLabel(.next)
                    
                    CustomTextField(text: $viewModel.password, hint: "Password", leadingIcon: Image(systemName: "lock"), isPassword: true)
                        .submitLabel(.continue)
                }
                .padding(.horizontal)
                
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(.black)
                        }
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                Spacer()
                
                HStack {
                    Text("Already have an account")
                        .foregroundColor(.gray)

                    Button("Login Now") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                }
                .font(.callout)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text(viewModel.authError?.description ?? ""))
            }
            .preferredColorScheme(.light)
        }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
