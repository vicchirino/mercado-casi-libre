//
//  ImageService.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import UIKit

final class ImageService {
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            var image: UIImage?
    
            defer {
                // Execute handler on main thread
                DispatchQueue.main.async {
                    // Execute handler
                    completion(image)
                }
            }
            
            if let data = data {
                // Create image from Data
                image = UIImage(data: data)
            }
        }
        dataTask.resume()
        return dataTask
        
    }
    
    func image(for string: String, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        guard let url = URL(string: string) else {
            fatalError("Can't create URL")
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            var image: UIImage?
    
            defer {
                // Execute handler on main thread
                DispatchQueue.main.async {
                    // Execute handler
                    completion(image)
                }
            }
            
            if let data = data {
                // Create image from Data
                image = UIImage(data: data)
            }
        }
        dataTask.resume()
        return dataTask
    }
}
