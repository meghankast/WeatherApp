//
//  AppViewModel.swift
//  WeatherApp (iOS)
//
//  Created by David Munechika on 9/9/22.
//

import SwiftUI
import FirebaseAuth

private let defaultIcon = "❓"
private let iconMap = [
  "Drizzle" : "🌧",
  "Thunderstorm" : "⛈",
  "Rain": "🌧",
  "Snow": "❄️",
  "Clear": "☀️",
  "Clouds" : "☁️",
]

class AppViewModel: ObservableObject {
    struct APIResponse: Decodable {
      let name: String
      let main: APIMain
      let weather: [APIWeather]
    }

    struct APIMain: Decodable {
      let temp: Double
    }

    struct APIWeather: Decodable {
      let description: String
      let iconName: String
      
      enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
      }
    }
    
    init() {
        currWeather()
    }
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon

    private let API_KEY = "f32da482d31f07ce7d03b407ac69f1a6"
    private var dataTask: URLSessionDataTask?
    
    func currWeather() {
        guard let urlString =
          "https://api.openweathermap.org/data/2.5/weather?zip=30308,us&appid=\(API_KEY)&units=imperial"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        // Cancel previous task
        dataTask?.cancel()

        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
          guard error == nil, let data = data else { return }
      
          if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
              self.temperature = "\(Int(response.main.temp))"
              self.weatherDescription = response.weather.first?.description ?? ""
              self.weatherIcon = iconMap[response.weather.first?.iconName ?? ""] ?? defaultIcon
          }
        }
        
        dataTask?.resume()
        
        
    }
    

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
