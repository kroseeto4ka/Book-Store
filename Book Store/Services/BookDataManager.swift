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

extension BookDataManager: IBookDataManager {
    
    func getTypesAmount() -> Int {
        var types: Set<String> = []
        for book in books {
            types.insert(book.type)
        }
        print(types.count)
        return types.count
    }
    
    func getBooksOfTypeAmount(type: String) -> Int {
        for bookModel in books {
            if bookModel.type == type {
                print(bookModel.books.count)
                return bookModel.books.count
            }
        }
        return 0
    }
    
    func getBooksOfType(type: String) -> [BookModel] {
        var booksOfType: [BookModel] = []
        for book in self.books {
            if book.type == type {
                booksOfType.append(book)
            }
        }
        print(booksOfType)
        return booksOfType
    }
    
    func getTypeByIndex(index: Int) -> String {
        print(books[index].type)
        return books[index].type
    }
    
    func getBookNameByIndex(section: Int, row: Int) -> String {
        print(books[section].books[row].title)
        return books[section].books[row].title
    }
    
    func getImageNameByIndex(section: Int, row: Int) -> String {
        print (books[section].books[row].image)
        return books[section].books[row].image
    }
    
    func getMarkByIndex(section: Int, row: Int) -> Bool {
        print(books[section].books[row].isNew)
        return books[section].books[row].isNew
    }
}
