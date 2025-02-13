//
//  BookModel.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

struct BookModel {
    let type: String
    var books: [Book]
}

extension BookModel: Hashable {}
