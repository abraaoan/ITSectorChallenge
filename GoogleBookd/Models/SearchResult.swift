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
    let items: [Book]
}
