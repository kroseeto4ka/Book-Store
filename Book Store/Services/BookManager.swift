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
            ]),
            BookModel(type: "Популярные книги", books: [
                Book(image: BookImages.book10, title: "Тайна черного замка"),
                Book(image: BookImages.book11, title: "Звездный путь", isNew: true),
                Book(image: BookImages.book12, title: "Секреты древнего ордена"),
                Book(image: BookImages.book13, title: "Город в облаках"),
                Book(image: BookImages.book14, title: "Тени прошлого")
            ]),
            BookModel(type: "Рекомендуем вам", books: [
                Book(image: BookImages.book15, title: "Лабиринт времени"),
                Book(image: BookImages.book16, title: "Сокровище пустыни", isNew: true),
                Book(image: BookImages.book17, title: "Огненный шторм"),
                Book(image: BookImages.book18, title: "Тайна ледяного острова"),
                Book(image: BookImages.book19, title: "Последний рубеж")
            ]),
            BookModel(type: "Классика", books: [
                Book(image: BookImages.book20, title: "1984"),
                Book(image: BookImages.book21, title: "Мастер и Маргарита"),
                Book(image: BookImages.book22, title: "Война и мир"),
                Book(image: BookImages.book23, title: "Преступление и наказание"),
                Book(image: BookImages.book24, title: "Гордость и предубеждение")
            ]),
            BookModel(type: "Фантастика", books: [
                Book(image: BookImages.book25, title: "Дюна"),
                Book(image: BookImages.book26, title: "Гиперион"),
                Book(image: BookImages.book27, title: "Нейромант"),
                Book(image: BookImages.book28, title: "Основание"),
                Book(image: BookImages.book29, title: "Снежная королева")
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
    static let book10 = "book10"
    static let book11 = "book11"
    static let book12 = "book12"
    static let book13 = "book13"
    static let book14 = "book14"
    static let book15 = "book15"
    static let book16 = "book16"
    static let book17 = "book17"
    static let book18 = "book18"
    static let book19 = "book19"
    static let book20 = "book20"
    static let book21 = "book21"
    static let book22 = "book22"
    static let book23 = "book23"
    static let book24 = "book24"
    static let book25 = "book25"
    static let book26 = "book26"
    static let book27 = "book27"
    static let book28 = "book28"
    static let book29 = "book29"
}
