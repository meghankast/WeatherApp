//
//  ContentView.swift
//  Shared
//
//  Created by Meghan Kast on 8/28/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false

    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }

    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }

    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                AppMainPageView()
            } else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}



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
                        }.padding()
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
                        }.padding(.trailing, 32)

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
                            .foregroundColor(Color.white)})
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
                        }.padding()
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
                        }.padding(.trailing, 32)

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
                    }, label: {Text("Create Account")
                            .fontWeight(.bold)
                            .frame(width:150, height:30)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(30)
                            .foregroundColor(Color.white)})
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

struct AppMainPageView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ZStack {
            VStack(alignment: .center){
                Text("Today's Weather!")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .padding()
                VStack {
                    Button(action: { viewModel.signOut()}, label: {Text("Sign Out").fontWeight(.bold)
                            .frame(width:150, height:30)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(30)
                            .foregroundColor(Color.white)})
                    }
                    Spacer()
                .background(Color(red: 0.65, green: 0.83, blue: 0.85))
            }
            .background(Color(red: 0.65, green: 0.83, blue: 0.85))
        }
        .background(Color(red: 0.65, green: 0.83, blue: 0.85))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(AppViewModel())
        }
    }
}
