//
//  ImageCache.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    let cachedImages = NSCache<NSURL, UIImage>()
    var loadingResponses = [NSURL: [(BookViewModel) -> ()]]()
    
    func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    func load(book: BookViewModel, completion: @escaping (BookViewModel) -> ()) {
        
        guard let url = book.imageUrl as NSURL? else { return }
        
        if let cachedImage = image(url: url) {
            book.image = cachedImage
            completion(book)
            return
        }
        
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        ABRequest.downloadImage(url: url as URL) { (image, data) in
            guard let image = image,
                let data = data,
                let blocks = self.loadingResponses[url] else {
                    DispatchQueue.main.async {
                        completion(book)
                    }
                    return
            }
            
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: data.count)
            
            for block in blocks {
                DispatchQueue.main.async {
                    book.image = image
                    block(book)
                }
                return
            }
        }
    }
}
