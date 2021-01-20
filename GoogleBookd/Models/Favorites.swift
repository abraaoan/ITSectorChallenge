//
//  Favorites.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 20/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class Favorites {

    static let shared = Favorites()
    var likes = [String]()
    
    init() {
        self.loadFavorites()
    }
    
    func loadFavorites() {
        if let likes = UserDefaults.standard.value(forKey: kLikes) as? [String] {
            self.likes = likes
        }
    }
    
    func add(_ bookId: String) {
        self.likes.append(bookId)
        self.save()
    }
    
    func remove(_ bookId: String) {
        if let index = self.likes.firstIndex(of: bookId) {
            self.likes.remove(at: index)
            self.save()
        }
    }
    
    func isBookLiked(_ bookId: String) -> Bool {
        return self.likes.contains(bookId)
    }
    
    private func save() {
        UserDefaults.standard.set(self.likes, forKey: kLikes)
    }
    
}
