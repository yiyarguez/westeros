//
//  UIImageView+Remote.swift
//  Westeros
//
//  Created by Kary Rguez on 12/09/24.
//

import UIKit

extension UIImageView {
    
    func setImage(url: URL) {
        // Capturamos self para no crear dependencias circulares
        downloadWithURLSession(url: url) { [weak self] image in
            DispatchQueue.main.async { // Hilo principal
                self?.image = image
            }
        }
    }
    
    //Este método obtiene una imagen a partir de una URL. Utiliza URLSession para ello
    
    private func downloadWithURLSession(
        url: URL,
        completion: @escaping (UIImage?) -> Void
    ) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            guard let data, let image = UIImage(data: data) else {
                // No puedo desempaquetar data ni la imagen, llamo al completio con nil
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
}
