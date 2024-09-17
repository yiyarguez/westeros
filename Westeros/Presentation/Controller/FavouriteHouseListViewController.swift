//
//  FavouriteHouseListViewController.swift
//  Westeros
//
//  Created by Kary Rguez on 12/09/24.
//

import UIKit

private let reuseIdentifier = "Cell"

final class FavouriteHouseListViewController: UICollectionViewController {
    // MARK: - DataSource
    typealias DataSource = UICollectionViewDiffableDataSource<Int, House>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, House>
    
    // MARK: - Model
    private var favouriteHouses = [String: House]()
    private var dataSource: DataSource?
    
    // MARK: - Initializers
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 125)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registration = UICollectionView.CellRegistration<
            FavouriteHouseCollectionViewCell,
            House>(cellNib: UINib(nibName: FavouriteHouseCollectionViewCell.identifier, bundle: nil) ) { cell, _, house in
                cell.configure(with: house)
            }
        
        dataSource = DataSource(collectionView: collectionView) {
            collectionView, indexPath, house in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: house)
        }
        
        collectionView.dataSource = dataSource
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(favouriteHouses.values))
        
        dataSource?.apply(snapshot)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceive), // Aquí llegarán los eventos
            name: .didToggleFavourite,
            object: nil // debe ser nulo
        )
    }
    
    @objc // Es para decirle al compilador que se puede leer desde objective-c
    func didReceive(_ notification: Notification) {
        // Obtener la información de la notificación (evento)
        guard let info = notification.userInfo,
              let house = info["house"] as? House,
        var snapshot = dataSource?.snapshot() else {
            return
        }
        if let foundHouse = favouriteHouses[house.rawValue] {
            favouriteHouses.removeValue(forKey: foundHouse.rawValue)
            snapshot.deleteItems([foundHouse])
        } else {
            favouriteHouses[house.rawValue] = house
            snapshot.appendItems([house])
        }
        
        // Procesar la información
        // Refrescar la vista
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        
    }
}
