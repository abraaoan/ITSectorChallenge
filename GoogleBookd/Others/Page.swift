//
//  Page.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class Page: NSObject {
    
    var currentPage: Int
    var total: Int
    var loadNextPage: ((Int) -> ())?
    
    private let loadNextWhenIndexEqual = 16
    
    init(_ result: SearchResult) {
        self.total = result.totalItems
        self.currentPage = 1   
    }
    
    func shouldLoadMore(_ index: Int) {
        
        let nextPage = currentPage + 1
        if nextPage == (total / Router.perPage) { return }
        if index == 0 { return }
        
        let indexPage = floor(Double(index) / Double(loadNextWhenIndexEqual))
        if Int(indexPage) == nextPage { return }
        
        if index % loadNextWhenIndexEqual == 0 {
            loadNextPage?(nextPage)
            self.currentPage = nextPage
        }
    }

}
