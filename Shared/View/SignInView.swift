//
//  SignInView.swift
//  WeatherApp (iOS)
//
//  Created by David Munechika on 9/9/22.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSecured: Bool = true
    
    var body: some View {
        ZStack {
            VStack(alignment: .center){
                Text("Weather Tracker")
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .padding()
                Image("WeatherIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 200, height: 150, alignment: .center)
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
                        viewModel.signIn(email: email, password: password)
                    }, label: {Text("Sign In")
                            .fontWeight(.bold)
                            .frame(width:150, height:30)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(30)
                            .foregroundColor(Color.white)
                    })
                    .padding()
                    NavigationLink("Create Account", destination: SignUpView())
                }
                .padding()
                Spacer()
            }
            .background(Color(red: 0.65, green: 0.83, blue: 0.85))
        }
        .background(Color(red: 0.65, green: 0.83, blue: 0.85))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
