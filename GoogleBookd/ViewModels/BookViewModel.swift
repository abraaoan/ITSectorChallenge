//
//  BookViewModel.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class BookViewModel: NSObject {
    
    var book: Book {
        didSet {
            if let amount = book.saleInfo?.retailPrice?.amount {
                self.setPrice(price: amount)
            } else if let amountInMicros = book.saleInfo?.retailPrice?.amountInMicros {
                let price = amountInMicros / 100
                self.setPrice(price: Double(price))
            }
        }
    }
    var image: UIImage?
    var imageUrl: URL?
    var detailImageUrl: URL?
    var title: String
    var bookDescription: String
    var isAvailable: Bool = false
    var buyLink: String?
    var price: String?
    
    init(_ book: Book) {
        self.book = book
        
        self.title = book.volumeInfo?.title ?? "-"
        self.bookDescription = book.volumeInfo?.description ?? ""
        
        if let saleability = book.saleInfo?.saleability {
            self.isAvailable = saleability == "FOR_SALE"
        }
        
        if let buyLink = book.saleInfo?.buyLink {
            self.buyLink = buyLink
        }
        
        if let imageUrl = book.volumeInfo?.imageLinks["thumbnail"] {
            self.imageUrl = URL(string: imageUrl)
        }
    }
    
    func setPrice(price: Double) {
        
        var currencySimbol = ""
        
        if let currencyCode = book.saleInfo?.retailPrice?.currencyCode{
            currencySimbol = Utils.getSymbol(forCurrencyCode: currencyCode) ?? ""
        }
        
        self.price = "\(currencySimbol) \(price)"
    }
}
