//
//  DalleViewModel.swift
//  DalleImageSwiftui
//
//  Created by masaki on 2023/02/04.
//

import Foundation
class DalleViewModel: ObservableObject {
    
    let session = UUID().uuidString
    
    func generateImage(text: String) async throws -> ImageModel {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else { throw ImageError.badURL }
        let parameters: [String: Any] = [
            "prompt": text,
            "n": 1,
            "size": "1024x1024",
            "user": session
        ]
        
        let data: Data = try  JSONSerialization.data(withJSONObject: parameters)
        let apikey = "your api key generated in openai website"
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data
        
        let (response, _)  = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ImageModel.self, from: response)
        return result
    }
}

enum ImageError: Error {
    case badURL
}
