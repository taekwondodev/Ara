//
//  OpenAIClassifier.swift
//  Deaf
//
//  Created by Davide Galdiero on 01/06/24.
//

import Foundation

class OpenAIClassifier {
    static func generateWhisperURLRequest(httpMethod: HTTPMethod, audioFile: Data) throws -> URLRequest {
        ///url API Whisper Endpoint
        guard let url = URL(string: "https://api.openai.com/v1/audio/transcriptions") else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Header
        urlRequest.addValue("applicaton/json", forHTTPHeaderField: "Content-Type")  //deve restituire un json
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")  //apiKey
        
        //Body
        ///Body in chiamata GET vuoto perchè stai mandando, in chamata POST quello che ti deve tornare
        let body = WhisperCall(nameModel: "whisper-1", audioFile: audioFile)
        let jsonData = try JSONEncoder().encode(body)
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    static func sendPromptToWhisper(audioFile: Data) async throws -> String{
        let urlRequest = try generateWhisperURLRequest(httpMethod: .post, audioFile: audioFile)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        //data -> è il file json risultante
        let response = try JSONDecoder().decode(WhisperResponse.self, from: data)
        print(String(data: data, encoding: .utf8)!)
        print(response)
        
        return response.text
    }
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
}

///PER IL BODY DI CHATGPT, ti devi far passare message come parametro
struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct WhisperCall: Encodable {
    let nameModel: String
    let audioFile: Data
}

///RESPONSE
struct WhisperResponse: Decodable{
    let text: String
}
