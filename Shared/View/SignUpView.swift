//
//  SignUpView.swift
//  WeatherApp (iOS)
//
//  Created by David Munechika on 9/9/22.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSecured: Bool = true
    
    var body: some View {
        ZStack {
            VStack(alignment: .center){
                Text("Create Account")
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .padding()
                VStack {
                    ZStack(alignment: .trailing) {
                        Group {
                            TextField("Email Address", text: $email)
                                .padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(20)
                                .padding(.trailing, 32)
                        }
                        .padding()
                    }
                    
                    ZStack(alignment: .trailing) {
                        Group {
                            if isSecured {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(20)
                                    .padding()
                            } else {
                                TextField("Password", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(20)
                                    .padding()
                            }
                        }
                        .padding(.trailing, 32)

                        Button(action: {
                            isSecured.toggle()
                        }) {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(.black)
                        }
                    }
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.signUp(email: email, password: password)
                    }, label: {
                        Text("Create Account")
                            .fontWeight(.bold)
                            .frame(width:150, height:30)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(30)
                            .foregroundColor(Color.white)
                    })
                    .padding()
                }
                .padding()
                Spacer()
            }
            .background(Color(red: 0.65, green: 0.83, blue: 0.85))
        }
        .background(Color(red: 0.65, green: 0.83, blue: 0.85))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
