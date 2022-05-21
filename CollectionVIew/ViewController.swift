//
//  ViewController.swift
//  CollectionVIew
//
//  Created by Uriel Hernandez Gonzalez on 20/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
    }


    func configureLayout() -> UICollectionViewCompositionalLayout {
        // fractionalWidth indica que el ancho del item va a ser una decima parte el ancho del grupo
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NumberCell.reuseIdentifier,
                for: indexPath) as? NumberCell else {
                fatalError("Could not deque cell")
            }
            
            cell.textLabel.text = itemIdentifier.description
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100), toSection: .main)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
}

