//
//  Book.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

struct Book: Codable {
    
    let kind: String
    let id: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    let accessInfo: [String: Any]? = nil
    let searchInfo: [String: Any]? = nil
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case selfLink
        case volumeInfo
        case saleInfo
    }
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let readingModes: [String: Any]? = nil
    let pageCount: Int
    let printType: String? = nil
    let categories: [String]? = nil
    let maturityRating: String? = nil
    let allowAnonLogging: Bool? = nil
    let contentVersion: String? = nil
    let panelizationSummary: [String: Any]? = nil
    let imageLinks: [String: String]
    let language: String? = nil
    let previewLink: String
    let infoLink: String
    let canonicalVolumeLink: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case publishedDate
        case description
        case pageCount
        case imageLinks
        case previewLink
        case infoLink
    }
}

struct SaleInfo: Codable {
    let country: String
    let saleability: String
    let isEbook: Bool
    let listPrice: [String: Any]? = nil
    let retailPrice: RetailPrice
    let buyLink: String
    let offers: [[String: Any]]? = nil
    
    private enum CodingKeys: String, CodingKey {
        case country
        case saleability
        case isEbook
        case retailPrice
        case buyLink
    }
}

struct RetailPrice: Codable {
    let amount: Double
    let currencyCode: String
}
