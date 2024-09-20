//
//  NetworkModel.swift
//  Westeros
//
//  Created by Kary Rguez on 19/09/24.
//  Command + New -> Swift File

import Foundation

final class NetworkModel {
    // Estamos creando el NetworkModel como singleton
    static let shared = NetworkModel()
    
    // https://thronesapi.com
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thronesapi.com"
        return components
    }
    
    private let client: APIClientProtocol
    
    private init(client: APIClientProtocol = APIClient()) {
        self.client =  client
    }
    
    func getAllCharacters(
        completion: @escaping ([GOTCharacter]?, Error?) -> Void
    
    ) {
        // Vamos a crear nuestra url request
        var components = baseComponents
        components.path = "/api/v2/Characters"
        
        // Obetener una url valida
        guard let url = components.url else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        client.requestCharacters(urlRequest, completion: completion)
    }
}
