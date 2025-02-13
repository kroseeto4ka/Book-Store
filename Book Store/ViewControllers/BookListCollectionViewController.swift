//
//  ViewController.swift
//  Book Store
//
//  Created by Никита Сорочинский on 07.01.2025.
//

import UIKit

final class BookListCollectionViewController: UIViewController {
    
    private let reuseIdentifier = "reuseIdentifier"
    private var collectionView: UICollectionView!
    private var diffableDataSource: UICollectionViewDiffableDataSource<BookModel, Book>!
    var bookManager: IBookDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        configureDataSource()
        applyInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}
//MARK: - Setup View
private extension BookListCollectionViewController {
    func setupView() {
        view.backgroundColor = .systemGray2
        
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
        
        collectionView.backgroundColor = .systemGray2
        
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Доступные книги"
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .systemGray
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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

//MARK: - UICollectionViewDelegate
extension BookListCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailViewController(book: bookManager?.getBookByIndex(section: indexPath.section, row: indexPath.row) ?? Book())
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Settings DiffableDataSource
extension BookListCollectionViewController {
    func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
            cell.configure(title: self.bookManager?.getBookNameByIndex(section: indexPath.section, row: indexPath.row) ?? "",
                           image: self.bookManager?.getImageNameByIndex(section: indexPath.section, row: indexPath.row) ?? "")
            
            return cell
        }
        
        diffableDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == ElementKind.badge {
                let badgeView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: BadgeView.reuseIdentifier,
                    for: indexPath) as! BadgeView
                
                badgeView.configureBadge(text: "New!")
                badgeView.isHidden = !(self.bookManager?.getMarkByIndex(section: indexPath.section, row: indexPath.row) ?? false)
                return badgeView
            } else if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath) as! SectionHeaderView
                
                headerView.configure(text: self.bookManager?.getTypeByIndex(index: indexPath.section) ?? "")
                return headerView
            }
            return nil
        }
    }
    
    func applyInitialData() {
        var snapshot = NSDiffableDataSourceSnapshot<BookModel, Book>()
        
        let sections = bookManager?.getAllTypes() ?? []
        
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.books, toSection: section)
        }
        
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
}

struct ElementKind {
    static let badge = "badge"
    static let background = "background"
}
