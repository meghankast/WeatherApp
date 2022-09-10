//
//  MainPageView.swift
//  WeatherApp (iOS)
//
//  Created by David Munechika on 9/9/22.
//

import SwiftUI

struct MainPageView: View {
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
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .fontWeight(.bold)
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

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
