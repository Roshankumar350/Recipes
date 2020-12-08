//
//  UIImageView+Extension.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import UIKit

extension UIImage {
    static var imageCache = [URL: UIImage?]()
    class func getImage(forURLString string: String, completion: @escaping (String, UIImage?) -> Swift.Void) {
        
        guard let url = URL(string: string) else {
            return completion(string, nil)
        }
        
        if let imageFromCache = UIImage.imageCache[url] {
            completion(string, imageFromCache)
        } else {
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let imageData = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        UIImage.imageCache[url] = image
                        completion(string, image)
                    }
                } catch {
                    completion(string, nil)
                }
            }
        }
    }
}

