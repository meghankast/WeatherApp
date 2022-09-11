//
//  ContentView.swift
//  Shared
//
//  Created by Meghan Kast on 8/28/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                MainPageView(viewModel: viewModel)
            } else {
                SignInView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: AppViewModel())
                .preferredColorScheme(.light)
        }
    }
}
