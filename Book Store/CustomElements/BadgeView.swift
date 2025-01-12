//
//  ItemBadgeView.swift
//  Book Store
//
//  Created by Никита Сорочинский on 1/12/25.
//

import UIKit

class BadgeView: UICollectionReusableView {
    static let reuseIdentifier = "BadgeView"
    private let badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBadge(text: String) {
        badgeLabel.text = text
    }
}

private extension BadgeView {
    func setupView() {
        badgeLabel.frame = bounds
        badgeLabel.backgroundColor = .systemTeal
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = bounds.width / 4
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
    }
}
