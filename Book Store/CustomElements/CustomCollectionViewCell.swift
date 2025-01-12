//
//  CustomCollectionViewCell.swift
//  Book Store
//
//  Created by Никита Сорочинский on 1/7/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private let bookImage = UIImageView()
    private let newLabel = UILabel()
    private let bookName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, image: String, isNew: Bool) {
        bookImage.image = UIImage(named: image)
        bookName.text = title
    }
    
    private func setupViews() {
        setupBookImage()
        setupBookName()
    }
    
    private func setupBookImage() {
        bookImage.contentMode = .scaleAspectFill
        bookImage.clipsToBounds = true
        bookImage.layer.cornerRadius = 10
        addSubview(bookImage)
    }
    
    private func setupBookName() {
        bookName.font = .systemFont(ofSize: 14)
        bookName.textColor = .white
        bookName.numberOfLines = 0
        addSubview(bookName)
    }
    
    private func setupLayout() {
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        bookName.translatesAutoresizingMaskIntoConstraints = false
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bookImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookImage.topAnchor.constraint(equalTo: topAnchor),
            bookImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            bookName.leadingAnchor.constraint(equalTo: leadingAnchor),
            bookName.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookName.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            bookName.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
