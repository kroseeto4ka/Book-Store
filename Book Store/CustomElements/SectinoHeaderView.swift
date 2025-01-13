//
//  SectinoHeaderView.swift
//  Book Store
//
//  Created by Никита Сорочинский on 1/12/25.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds // Размер лейбла, равень размер самого элемента SectionHeaderView
        label.textAlignment = .natural
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
}
