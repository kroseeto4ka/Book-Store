//
//  DetailViewController.swift
//  Book Store
//
//  Created by Никита Сорочинский on 2/8/25.
//

import UIKit

final class DetailViewController: UIViewController {
    var book: Book?
    
    var isHeartActive = false
    
    let image = UIImageView()
    let bookName = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarView()
    }
}

//MARK: - Setup View
private extension DetailViewController {
    private func setupView() {
        view.backgroundColor = .systemGray
        
        setupImageView()
        setupBookName()
    }
    
    private func setupImageView() {
        image.image = UIImage(named: book?.image ?? "")
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        
        view.addSubview(image)
    }
    
    private func setupBookName() {
        bookName.text = "«\(book?.title ?? "")»"
        bookName.font = .systemFont(ofSize: 24)
        bookName.textColor = .white
        
        view.addSubview(bookName)
    }
    
    private func setupNavigationBarView() {
        navigationItem.title = "Подробная информация"

        navigationController?.navigationBar.prefersLargeTitles = false
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = favoriteButton
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = (book?.isNew ?? false) ? .systemTeal : .systemGray
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc
    private func favoriteButtonTapped() {
        book?.toggleIsLiked()
        
        if book?.isLiked ?? true {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            navigationItem.rightBarButtonItem?.tintColor = .systemRed
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
    }
}

//MARK: - Setup Layout
private extension DetailViewController {
    private func setupLayout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        bookName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            
            bookName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            bookName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bookName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
        ])
    }
}
