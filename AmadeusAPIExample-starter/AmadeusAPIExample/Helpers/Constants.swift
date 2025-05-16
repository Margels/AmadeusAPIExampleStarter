//
//  Constants.swift
//  AmadeusBookingApp
//
//  Created by Margels on 06/10/23.
//

import Foundation
import Alamofire

final class Constants {
    
    static var shared = Constants()
    
    // Authorization
    private let authUrl = "https://test.api.amadeus.com/v1/security/oauth2/token"
    private let clientId = "YOUR_API_KEY"
    private let clientSecret = "YOUR_API_SECRET"
    
    // Composing URLs
    private let baseUrl = "https://test.api.amadeus.com/v1"
    private let getRequestEndpoint = "/reference-data/locations"
    private let postRequestEndpoint = "/shopping/availability/flight-availabilities"
    
    // MARK: - Auth Token
    
    func getAuthRequest(onError: ((String)->Void)?, completion: @escaping (String)->()) {
        
        // Create the URL
        guard let url = URL(string: self.authUrl) else { return }
        let parameters = "grant_type=client_credentials&client_id=\(clientId)&client_secret=\(clientSecret)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: .utf8)
        
        // Create the task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check for errors
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            
            // Check for error status
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                onError?("Invalid response")
                return
            }
            
            // Check that response data is available
            guard let responseData = data else { return }
            
            // Decode auth response
            let decoder = JSONDecoder()
            do {
                let authResponse = try decoder.decode(AuthResponse.self, from: responseData)
                completion("\(authResponse.token_type) \(authResponse.access_token)")
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
    // MARK: - GET Requests
    
    // GET without mapping response
    // TODO 1
    
    // GET mapping response
    // TODO 2
    
    
    
    // MARK: - POST Requests
    
    // POST without mapping response
    // TODO 3
    
    // POST without mapping response
    // TODO 4

    
    // MARK: - Alamofire
    
    // GET with Alamofire
    // TODO 5
    
}
