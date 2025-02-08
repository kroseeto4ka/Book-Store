//
//  IBookDataManager.swift
//  Book Store
//
//  Created by Никита Сорочинский on 1/8/25.
//

protocol IBookDataManager {
    func getBooksOfType(type: String) -> [BookModel]
    func getTypesAmount() -> Int
    func getBooksOfTypeAmount(type: String) -> Int
    func getTypeByIndex(index: Int) -> String
    func getBookNameByIndex(section: Int, row: Int) -> String
    func getImageNameByIndex(section: Int, row: Int) -> String
    func getMarkByIndex(section: Int, row: Int) -> Bool
    func getBooksOfIndex(index: Int) -> [Book]
    func getAllTypes() -> [BookModel]
    func getBookByIndex(section: Int, row: Int) -> Book
}
