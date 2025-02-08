//
//  Book.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

struct Book {
    let image: String
    let title: String
    var isNew = false
    
    init(image: String, title: String, isNew: Bool) {
        self.image = image
        self.title = title
        self.isNew = isNew
    }
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
    
    init() {
        self.image = ""
        self.title = ""
    }
}

extension Book: Hashable {}
