//
//  AppViewModel.swift
//  WeatherApp (iOS)
//
//  Created by David Munechika on 9/9/22.
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
