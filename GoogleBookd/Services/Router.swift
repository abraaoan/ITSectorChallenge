//
//  Router.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

enum Router {
    
    case searchWith(query: String, page: Int)
    case getBookBy(id: String)
    
    private static let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    private static let perPage = 20
    
    private var path: String {
        
        switch self {
        case .searchWith:
            return "\(Router.baseUrl)?q=:query&maxResults=\(Router.perPage)&startIndex=:page"
        case .getBookBy:
            return "\(Router.baseUrl)/:bookId"
        }
    }
    
    func request() throws -> URLRequest? {
        
        switch self {
        case .searchWith(let query, let page):
            var path = self.path.replacingOccurrences(of: ":query", with: query)
            path = path.replacingOccurrences(of: ":page", with: String(page))
            guard let searchUrl = URL(string: path) else { throw ErrorType.urlFail }
            return ABRequest.makeRequest(url: searchUrl)
        case .getBookBy(let bookId):
            let path = self.path.replacingOccurrences(of: ":bookId", with: bookId)
            guard let photoUrl = URL(string: path) else { throw ErrorType.urlFail }
            return ABRequest.makeRequest(url: photoUrl)
        }
    }
}
