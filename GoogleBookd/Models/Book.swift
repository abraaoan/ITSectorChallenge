//
//  Book.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

struct Book: Codable {
    
    let kind: String?
    let id: String?
    let etag: String? = nil
    let selfLink: String?
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: [String: Any]? = nil
    let searchInfo: [String: Any]? = nil
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case selfLink
        case volumeInfo
        case saleInfo
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.kind = try? values.decode(String.self, forKey: .kind)
        self.id = try? values.decode(String.self, forKey: .id)
        self.selfLink = try? values.decode(String.self, forKey: .selfLink)
        self.volumeInfo = try? values.decode(VolumeInfo.self, forKey: .volumeInfo)
        self.saleInfo = try? values.decode(SaleInfo.self, forKey: .saleInfo)
        
    }
    
}

struct VolumeInfo: Codable {
    
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let readingModes: [String: Any]? = nil
    let pageCount: Int?
    let printType: String? = nil
    let categories: [String]? = nil
    let maturityRating: String? = nil
    let allowAnonLogging: Bool? = nil
    let contentVersion: String? = nil
    let panelizationSummary: [String: Any]? = nil
    let imageLinks: [String: String]
    let language: String? = nil
    let previewLink: String? = nil
    let infoLink: String?
    let canonicalVolumeLink: String? = nil
    let industryIdentifiers: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case publishedDate
        case description
        case pageCount
        case imageLinks
        case infoLink
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try? values.decode(String.self, forKey: .title)
        self.publisher = try? values.decode(String.self, forKey: .publisher)
        self.publishedDate = try? values.decode(String.self, forKey: .publishedDate)
        self.description = try? values.decode(String.self, forKey: .description)
        self.pageCount = try? values.decode(Int.self, forKey: .pageCount)
        self.imageLinks = try values.decode([String: String].self, forKey: .imageLinks)
        self.infoLink = try? values.decode(String.self, forKey: .infoLink)
        self.authors = try? values.decode([String].self, forKey: .authors)
    }
}

struct SaleInfo: Codable {
    let country: String?
    let saleability: String?
    let isEbook: Bool?
    let listPrice: [String: Any]? = nil
    let retailPrice: RetailPrice?
    let buyLink: String?
    let offers: [[String: Any]]? = nil
    
    private enum CodingKeys: String, CodingKey {
        case country
        case saleability
        case isEbook
        case retailPrice
        case buyLink
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try? values.decode(String.self, forKey: .country)
        self.saleability = try? values.decode(String.self, forKey: .saleability)
        self.isEbook = try? values.decode(Bool.self, forKey: .isEbook)
        self.buyLink = try? values.decode(String.self, forKey: .buyLink)
        self.retailPrice = try? values.decode(RetailPrice.self, forKey: .retailPrice)
    }
}

struct RetailPrice: Codable {
    let amount: Double?
    let amountInMicros: Int?
    let currencyCode: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.amount = try? values.decode(Double.self, forKey: .amount)
        self.amountInMicros = try? values.decode(Int.self, forKey: .amountInMicros)
        self.currencyCode = try? values.decode(String.self, forKey: .currencyCode)
    }
}
