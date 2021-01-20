//
//  SearchResult.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

struct SearchResult: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]?
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try values.decode(String.self, forKey: .kind)
        self.totalItems = try values.decode(Int.self, forKey: .totalItems)
        self.items = try? values.decode([Book].self, forKey: .items)
        
    }
    
}
