//
//  BookDataManager.swift
//  Book Store
//
//  Created by Никита Сорочинский on 1/8/25.
//

class BookDataManager {
    var books: [BookModel] = []
    
    init(books: [BookModel]) {
        self.books = books
    }
}

//MARK: - IBookDataManager
extension BookDataManager: IBookDataManager {
    func getTypeByIndex(index: Int) -> String {
        return books[index].type
    }
    
    func getBookNameByIndex(section: Int, row: Int) -> String {
        return books[section].books[row].title
    }
    
    func getImageNameByIndex(section: Int, row: Int) -> String {
        return books[section].books[row].image
    }
    
    func getMarkByIndex(section: Int, row: Int) -> Bool {
        return books[section].books[row].isNew
    }
    
    func getBooksOfIndex(index: Int) -> [Book] { 
        books[index].books
    }
    
    func getAllTypes() -> [BookModel] {
        books
    }
    
    func getBookByIndex(section: Int, row: Int) -> Book {
        books[section].books[row]
    }
    
    func toggleIsLiked(section: Int, row: Int) {
        books[section].books[row].toggleIsLiked()
    }
}
