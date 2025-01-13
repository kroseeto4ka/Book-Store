//
//  SceneDelegate.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let viewController = BookListCollectionViewController()
        viewController.bookManager = setupBookManager()
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

//MARK: - BookManager Setup
extension SceneDelegate {
    func setupBookManager() -> IBookDataManager {
        let bookManager = BookManager()
        let bookDataManager = BookDataManager(books: bookManager.getBooks())
        
        return bookDataManager
    }
}
