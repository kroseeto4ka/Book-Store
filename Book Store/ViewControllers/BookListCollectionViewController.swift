//
//  ViewController.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

import UIKit

class BookListCollectionViewController: UIViewController {
    
    private let reuseIdentifier = "reuseIdentifier"
    private var collectionView: UICollectionView!
    var bookManager: IBookDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
}
//MARK: - Setup View
private extension BookListCollectionViewController {
    func setupView() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        collectionView.register(
            BadgeView.self,
            forSupplementaryViewOfKind: ElementKind.badge,
            withReuseIdentifier: BadgeView.reuseIdentifier
        )
        
        collectionView.backgroundColor = .systemGray
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
}

//MARK: - Setup Layout
private extension BookListCollectionViewController {
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Collection View Layout
private extension BookListCollectionViewController {
    func createLayout() -> UICollectionViewLayout {
        let item = createLayoutItem()
        let group = createLayoutGroup(item)
        let section = createLayoutSection(group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func createLayoutItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [createLayoutBadge()])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return item
    }
    
    private func createLayoutGroup(_ item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        return group
    }
    
    private func createLayoutHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return header
    }
    
    private func createLayoutBadge() -> NSCollectionLayoutSupplementaryItem {
        let supplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(40),
            heightDimension: .absolute(20)
        )
        
        let constraints = NSCollectionLayoutAnchor(
            edges: [.top, .leading],
            absoluteOffset: CGPoint(x: 0, y: -10)
        )
        
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: supplementaryItemSize,
            elementKind: ElementKind.badge,
            containerAnchor: constraints
        )
        
        return supplementaryItem
    }
    
    private func createLayoutSection(_ group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        section.boundarySupplementaryItems = [createLayoutHeader()]
        return section
    }
}


//MARK: - UICollectionViewDataSource
extension BookListCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        bookManager?.getTypesAmount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookManager?.getBooksOfTypeAmount(type: bookManager?.getTypeByIndex(index: section) ?? "") ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(
            title: bookManager?.getBookNameByIndex(section: indexPath.section, row: indexPath.row) ?? "",
            image: bookManager?.getImageNameByIndex(section: indexPath.section, row: indexPath.row) ?? "",
            isNew: bookManager?.getMarkByIndex(section: indexPath.section, row: indexPath.row) ?? false
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
                header.configure(text: bookManager?.getTypeByIndex(index: indexPath.section) ?? "")
                return header
        } else if kind == ElementKind.badge {
            let badge = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BadgeView.reuseIdentifier,
                for: indexPath) as! BadgeView
            badge.configureBadge(text: "New")
            badge.isHidden = !(bookManager?.getMarkByIndex(section: indexPath.section, row: indexPath.row) ?? false)
            return badge
        }
        return UICollectionReusableView()
    }
}

struct ElementKind {
    static let badge = "badge"
    static let background = "background"
}
