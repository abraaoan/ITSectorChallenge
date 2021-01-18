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
        
        let photosRouter = Router.searchWith(query: query, page: page)
        let abrequest = ABRequest()
        
        do {
            guard let request = try photosRouter.request() else {
                return
            }
            
            abrequest.requestObject(of: SearchResult.self, request: request) { (result) in
                switch result {
                case .success(let photos):
                    completion(photos as? SearchResult)
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
        
        let photosRouter = Router.getBookBy(id: bookId)
        let abrequest = ABRequest()
        
        do {
            guard let request = try photosRouter.request() else {
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
