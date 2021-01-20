//
//  Services.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class Services: NSObject {

    static func search(with query: String, page: Int = 1, completion: @escaping (SearchResult?) -> ()) {
        
        let booksRouter = Router.searchWith(query: query, page: page)
        let abrequest = ABRequest()
        
        do {
            guard let request = try booksRouter.request() else {
                return
            }
            
            abrequest.requestObject(of: SearchResult.self, request: request) { (result) in
                switch result {
                case .success(let books):
                    completion(books as? SearchResult)
                case .failure(let error):
                    completion(nil)
                    print("[Service]: parser error. \(error.localizedDescription)")
                }
            }
        } catch let error {
            completion(nil)
            print("[Service]: \(error.localizedDescription)")
        }
    }
    
    static func getDetail(with bookId: String, completion: @escaping (Book?)->()) {
        
        let bookRouter = Router.getBookBy(id: bookId)
        let abrequest = ABRequest()
        
        do {
            guard let request = try bookRouter.request() else {
                return
            }
            
            abrequest.requestObject(of: Book.self, request: request) { (result) in
                switch result {
                case .success(let book):
                    completion(book as? Book)
                case .failure(let error):
                    completion(nil)
                    print("[Service]: parser error. \(error.localizedDescription)")
                }
            }
        } catch let error {
            completion(nil)
            print("[Service]: \(error.localizedDescription)")
        }
    }
    
}
