//
//  BookManager.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

class BookManager {}

//MARK: IBookManager
extension BookManager: IBookManager {
    func getBooks() -> [BookModel] {
        [
            BookModel(type: "Выбор редакции", books: [
                Book(image: BookImages.book1, title: "Танец в тумане", isNew: true),
                Book(image: BookImages.book2, title: "Код апполона", isNew: true),
                Book(image: BookImages.book3, title: "Ловцы теней"),
                Book(image: BookImages.book4, title: "Призрак заброшеной башни", isNew: true),
                Book(image: BookImages.book5, title: "Симфония падших слов")
            ]),
            BookModel(type: "Новинки в подписке", books: [
                Book(image: BookImages.book6, title: "Когда океан шепчет"),
                Book(image: BookImages.book7, title: "Дракон и ветер"),
                Book(image: BookImages.book8, title: "Записки подземелий", isNew: true),
                Book(image: BookImages.book9, title: "Последняя пуля")
            ])
        ]
    }
}

enum BookImages {
    static let book1 = "danceInAMist"
    static let book2 = "appolosCode"
    static let book3 = "shadowCatchers"
    static let book4 = "theGhostOfAnAbondonedTower"
    static let book5 = "symphonyOfFallenWords"
    static let book6 = "whenTheOceanWhispers"
    static let book7 = "theDragonAndTheWind"
    static let book8 = "notesFromTheUnderground"
    static let book9 = "theLastBullet"
}
