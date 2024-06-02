//
//  OpenAIClassifier.swift
//  Deaf
//
//  Created by Davide Galdiero on 01/06/24.
//

import Foundation

class OpenAIClassifier {
    static func generateWhisperURLRequest(httpMethod: HTTPMethod, audioFile: Data, fileName: String) throws -> URLRequest {
        ///url API Whisper Endpoint
        guard let url = URL(string: "https://api.openai.com/v1/audio/transcriptions") else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Header
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        // urlRequest.addValue("applicaton/json", forHTTPHeaderField: "Content-Type")  //deve restituire un json
        urlRequest.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")  //apiKey
        
        //Body
        ///Body in chiamata GET vuoto perchè stai mandando, in chamata POST quello che ti deve tornare
        var body = Data()
        let parameters: [String: String] = [
            "model": "whisper-1"
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add audio file
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(audioFile)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        //let body = WhisperCall(model: "whisper-1", file: audioFile.base64EncodedData())
        //let jsonData = try JSONEncoder().encode(body)
//        urlRequest.httpBody = jsonData
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    static func sendPromptToWhisper(audioFile: Data, fileName: String) async throws -> String{
        let urlRequest = try generateWhisperURLRequest(httpMethod: .post, audioFile: audioFile, fileName: fileName)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(response.statusCode) else {
            // Handle HTTP errors
            print("HTTP Error: \(response.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        do {
            //data -> è il file json risultante
            let response = try JSONDecoder().decode(WhisperResponse.self, from: data)
            print(String(data: data, encoding: .utf8)!)
            print(response)
            
            return response.text
        }
        catch {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                // Handle error response from API
                print("API Error: \(errorResponse.error.message)")
                throw URLError(.cannotDecodeContentData)
            }
            print("Decoding Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
}

///PER IL BODY DI CHATGPT, ti devi far passare message come parametro
struct WhisperCall: Encodable {
    let model: String
    let file: Data
}

///RESPONSE
struct WhisperResponse: Decodable{
    let text: String
}

///ERROR
struct ErrorResponse: Decodable {
    let error: APIError
}

struct APIError: Decodable {
    let message: String
}
