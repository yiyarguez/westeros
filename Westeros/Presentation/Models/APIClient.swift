//
//  APIClient.swift
//  Westeros
//
//  Created by Kary Rguez on 19/09/24.
//  Command + New -> Swift File

import Foundation

// TODO: - Investigar todo este archivo
// Este es el código para hacer la petición al servidor para pobtener el Array de GOTCharacter

protocol APIClientProtocol {
    var session: URLSession { get }
    func requestCharacters(
        _ request: URLRequest,
        completion: @escaping ([GOTCharacter]?, Error?) -> Void
    )
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestCharacters(
        _ request: URLRequest,
        completion: @escaping ([GOTCharacter]?, Error?) -> Void) 
    {
        let task = session.dataTask(with: request) { data, response, error in
            // Compruebo si obtengo un error
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            // Compruebo si obtengo un objeto Data
            guard let data else {
                return
            }
            
            // Obtengo un código de estado de la respuesta del servidor por ejemplo status 200, 400, etc.
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            // Compruebo si el código de estado es 200
            //Tendríamos que ver la documentación de la API que estamos usando
            // Para comprobar los códigos de estado
            guard statusCode == 200 else {
                return
            }
            
            // Intentar decodificar un array de GOTCharacter a traves del objeto data
            // Este objeto data generalmente es el BODY de la respuesta del servidor
            guard let characters = try? JSONDecoder().decode([GOTCharacter].self, from: data) else {
                return
            }
            
            // Si pudimos decodificar el array de GOTCharacter, llamamos al completion handler
            completion(characters, nil)
        }
        
        // Muy importante ejecutar la tarea para enviar la petición al servidor !!!!
        task.resume()
    }
}
