//
//  TabBarController.swift
//  Book Store
//
//  Created by Никита Сорочинский on 2/13/25.
//

import UIKit

final class TabBarController: UITabBarController {
    let dataSource: [TabBarItem] = [.home, .search]
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabBarController()
        setupTabBar()
    }
}

//MARK: - Setup View
private extension TabBarController {
    private func buildTabBarController() {
        viewControllers = dataSource.map {
            switch $0 {
            case .home:
                let bookList = BookListCollectionViewController()
                bookList.bookManager = setupBookManager()
                let navController = UINavigationController(rootViewController: bookList)
                return navController
            case .search:
                let multipleSectionsVC = MultipleSectionsViewController()
                let navController = UINavigationController(rootViewController: multipleSectionsVC)
                return navController
            }
        }
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white // Устанавливаем чёрный фон
        
        // Настраиваем цвет для не активной иконки
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        // Настраиваем цвет для активной иконки
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        // Настраиваем цвет текста не активного title, так же можно задать ему размер и жирность
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        // Настраиваем цвет текста активного title
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // Присваеваем настроенный объект appearance в статичный экран без скролла
        tabBar.standardAppearance = appearance
        // Присваиваем настроенный appearance в экран с скроллом
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers?.enumerated().forEach { index, viewController in
            viewController.tabBarItem.title = dataSource[index].title
            viewController.tabBarItem.image = dataSource[index].icon
        }
    }
    
    func setupBookManager() -> IBookDataManager {
        let bookManager = BookManager()
        let bookDataManager = BookDataManager(books: bookManager.getBooks())
        
        return bookDataManager
    }
}

enum TabBarItem {
    case home
    case search
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass")
        }
    }
}
